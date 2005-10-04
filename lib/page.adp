<master>
  <property name="title">@title@</property>
  <property name="header_stuff">@header_stuff@</property>
  <property name="context">@context@</property>
  <property name="focus">@focus@</property>
  <property name="header_stuff"><link rel="stylesheet" type="text/css" href="/resources/wiki/wiki.css" media="all"></property>  


<if @related_items:rowcount@ gt 0>
<div class="wiki-related-page">
Pages that link to this page:
<ul>
<multiple name="related_items">
    <li><a href="@related_items.name@">@related_items.title@</a></li>
    </multiple>
</ul>
</div>
</if>

@content;noquote@



<include src="footer" edit_link_p="@edit_link_p@" >
