ad_page_contract {
    List recently changed wiki pages
}
set folder_id [wiki::get_folder_id]
db_multirow pages pages "select u.first_names || ' ' || u.last_name as modified_by, w.name, w.title, w.last_modified, w.creation_user from cr_revisionsx w, cr_items ci, acs_users_all u where ci.live_revision=w.revision_id and ci.parent_id=:folder_id and u.user_id=w.creation_user order by w.name" {
    set last_modified [lc_time_fmt $last_modified "%X %x"]
}
