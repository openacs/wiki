ad_page_contract {

 Show or edit wiki pages

 @author Dave Bauer (dave@thedesignexperience.org)
 @creation-date 2004-09-03
 @cvs-id $Id$

} -query {
    edit:optional
    revision_id:optional
}

set folder_id [wiki::get_folder_id]
set name [ad_conn path_info]
if {$name eq ""} {
    # the path resolves directly to a site node
    set name "index"
}
ns_log debug "
DB --------------------------------------------------------------------------------
DB DAVE debugging /var/lib/aolserver/openacs-5-1/packages/wiki/lib/page.tcl
DB --------------------------------------------------------------------------------
DB name = '${name}'
DB folder_id = '${folder_id}'
DB --------------------------------------------------------------------------------"
set item_id [content::item::get_id -item_path $name -resolve_index "t" -root_folder_id $folder_id]
if {[string equal "" $item_id]} {
    rp_form_put name [ad_conn path_info]
    rp_internal_redirect "/packages/wiki/lib/new"
    ad_script_abort
}

if {[info exists edit]} {
    set form [rp_getform]
    ns_log debug "
DB --------------------------------------------------------------------------------
DB DAVE debugging /var/lib/aolserver/openacs-5-head-cr-tcl-api/packages/wiki/lib/page.tcl
DB --------------------------------------------------------------------------------
DB form = '${form}'
DB [ns_set find $form "item_id"]
DB --------------------------------------------------------------------------------"
    if {[ns_set find $form "item_id"] < 0} {
        rp_form_put item_id $item_id
        rp_form_put name $name
    }
    rp_internal_redirect "/packages/wiki/lib/new"
}


if {![db_0or1row get_content "select content,title from cr_revisions, cr_items where revision_id=live_revision and cr_items.item_id=:item_id"]} {
    set form [rp_getform]
    ns_log debug "
DB --------------------------------------------------------------------------------
DB DAVE debugging /var/lib/aolserver/openacs-5-head-cr-tcl-api/packages/wiki/lib/page.tcl
DB --------------------------------------------------------------------------------
DB form = '${form}'
DB [ns_set find $form "item_id"]
DB --------------------------------------------------------------------------------"
    if {[ns_set find $form "item_id"] < 0} {
        rp_form_put item_id $item_id
        rp_form_put name $name
    }
    rp_internal_redirect "/packages/wiki/lib/new"
}

set stream [Wikit::Format::TextToStream $content]
set refs [Wikit::Format::StreamToRefs $stream "wiki::get_info"]

db_multirow related_items get_related_items "select cr.name, cr.title, cr.description from cr_revisionsx cr, cr_items ci, cr_item_rels cir where cir.related_object_id=:item_id and cir.relation_tag='wiki_reference' and ci.live_revision=cr.revision_id and ci.item_id=cir.item_id"

set content [ad_wiki_text_to_html $content "wiki::get_info"]
set context [list $title]
set focus ""
set header_stuff ""

set edit_link_p [permission::permission_p \
                 -object_id $item_id \
                 -party_id [ad_conn user_id] \
                 -privilege "write"
             ]

ad_return_template "page"
