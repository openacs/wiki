<master>
<property name="title">Recent Changes</property>
<h2>Recent Changes</h2>
<div style="line-height: 2.5ex; margin:5px;">
<multiple name="pages">
<group column="modified_in">
<if @pages.groupnum@ eq 1>
<h3>Modified @pages.modified_in@</h3></if>
<a href="@pages.name@">(@pages.name@) @pages.title@</a>  by @pages.modified_by@ on @pages.last_modified@<br />
</group>
</multiple>
</div>
<div><a href="doc/wiki-help">Help</a> | <a href="recent-changes">Recent Changes</a> | <a href="all-pages">All Pages</a></div>
