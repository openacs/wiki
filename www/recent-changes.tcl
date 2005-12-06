ad_page_contract {
    List recently changed wiki pages
}
set folder_id [wiki::get_folder_id]
db_multirow -extend {modified_in} pages pages "select current_date - w.last_modified :: date as days_old, u.first_names || ' ' || u.last_name as modified_by, w.name, w.title, w.last_modified, w.creation_user from cr_revisionsx w, cr_items ci, acs_users_all u where ci.live_revision=w.revision_id and ci.parent_id=:folder_id and u.user_id=w.creation_user order by w.last_modified desc" {
    set last_modified [lc_time_fmt $last_modified "%X %x"]
    if {$days_old == 0} {
	set modified_in "today"
    } elseif {$days_old == 1} {
	set modified_in "yesterday"
    } elseif {$days_old <= 7} {
	set modified_in "this week"
    } elseif {$days_old <=14} {
	set modified_in "2 weeks ago"
    } else {
	set modified_in "more than 2 weeks ago"
    }
}
