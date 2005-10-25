ReturnHeaders text/html
db_foreach get_items "select ci.parent_id as folder_id,cr.content, ci.item_id,ci.name from cr_items ci, cr_revisions cr where cr.item_id=ci.item_id and cr.revision_id=ci.live_revision and cr.mime_type like '%wiki%'" {
    ns_write "<h2>$item_id, $name </h2>"

    set stream [Wikit::Format::TextToStream $content]
    set refs [Wikit::Format::StreamToRefs $stream "wiki::get_info"]
    if {[llength $refs]} {
	array set existing_refs [list]
	db_foreach get_ids "select cr.rel_id, ci.item_id as ref_item_id, ci.name as ref_name from cr_items ci left join cr_item_rels cr on (cr.related_object_id=:item_id) where ci.parent_id=:folder_id and ci.name in ([template::util:::tcl_to_sql_list $refs]) and cr.rel_id is null" {
	    set existing_refs($ref_name) $ref_item_id
	    set existing_rels($ref_name) $rel_id
	}
	#    ad_return_complaint 1 " ref = '${refs}'"
	foreach ref $refs {
	    ns_write "looking for $ref - " 
	    if {![string equal "" $ref] && ![info exists existing_rels($ref)]} {
		set ref_item_id [content::item::get_id -root_folder_id $folder_id -item_path $ref]
		ns_write " <b>adding $ref $ref_item_id</b>"

		if {[string equal $ref_item_id ""]} {
		    ns_write "uhoh item_id is empty"
		} else {
		ns_write "new rel = '[content::item::relate \
				-item_id $item_id \
				-object_id $ref_item_id \
				-relation_tag "wiki_reference"]'"
		}
	    } else {
	       
	    }
	    ns_write "<br>"
	}
    }
}