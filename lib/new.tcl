ad_page_contract {
    create a new wiki page
} -query {
    name
    item_id:integer,optional
}

set folder_id [wiki::get_folder_id]
set user_id [ad_conn user_id]
set ip_address [ad_conn peeraddr]

permission::require_permission \
    -object_id $folder_id \
    -party_id $user_id \
    -privilege "create"

# this is a wiki so we can always force the
# format and don't need richtext widget
set edit ""
ad_form -name new -action "new" -export {name edit} -form {
    item_id:key
    title:text
    content:text(textarea)
    revision_notes:text(textarea),optional
    
} -edit_request {

    #    content::item::get -item_id $item_id
    db_0or1row get_item "select cr_items.item_id, title, content from cr_items, cr_revisions where name=:name and parent_id=:folder_id and latest_revision=revision_id"
    
}  -new_data {
    content::item::new \
        -name $name \
        -parent_id $folder_id \
        -creation_user $user_id \
        -creation_ip $ip_address \
        -title $title \
        -text $content \
        -description $revision_notes \
        -is_live "t" \
        -storage_type "text" \
        -mime_type "text/x-openacs-wiki"

    # see if any references exist that go to this page
    db_foreach get_refs "select cr.rel_id from cr_item_rels cr, cr_items ci where ci.item_id=cr.object_id and ci.parent_id=:folder_id and cr.related_object_id is null and cr.relation_tag = 'wiki_reference__' || $name" {
	db_dml update_rel "update cr_item_rels set related_object_id=:item_id where rel_id=:rel_id"
    }
    
} -edit_data {
    content::revision::new \
        -item_id $item_id \
        -title $title \
        -content $content \
        -description $revision_notes \
        -mime_type "text/x-openacs-wiki" \
	-is_live "t"

} -after_submit {    
    # do something clever with internal refs
    set stream [Wikit::Format::TextToStream $content]
    set refs [Wikit::Format::StreamToRefs $stream "wiki::get_info"]
    if {[llength $refs]} {
        
        array set existing_refs [list]
        # get references that have cr_items already
        db_foreach get_ids "select cr.rel_id,ci.item_id as ref_item_id, ci.name as ref_name from cr_items ci left join cr_item_rels cr on (cr.related_object_id=:item_id) where ci.parent_id=:folder_id and ci.name in ([template::util:::tcl_to_sql_list $refs])" {
            set existing_refs($ref_name) $ref_item_id
        }

        foreach ref $refs {
            # if there isn't an existing reference to a cr_item, create a
            # new one and create the cr_item_rel
            # leave the content blank until someone edits the page
            if {![string equal "" $ref] && ![info exists existing_refs($ref)]} {
                # no page exists for this link yet, create a placeholder
                set existing_refs($ref) [content::item::new \
                                             -name $ref \
                                             -parent_id $folder_id \
                                             -creation_user $user_id \
                                             -creation_ip $ip_address \
                                             -is_live "t" \
                                             -storage_type "text" \
                                             -mime_type "text/x-openacs-wiki"]

                content::item::relate \
                    -item_id $item_id \
                    -object_id $existing_refs($ref) \
                    -relation_tag "wiki_reference"
            }
            
        } 
    }
    ad_returnredirect "./$name"

} 

set title ""
set context [list $title]
set header_stuff ""
set focus ""

ad_return_template


