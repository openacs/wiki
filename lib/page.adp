<master>
  <property name="title">@title@</property>
  <property name="header_stuff">@header_stuff@</property>
  <property name="context">@context@</property>
  <property name="focus">@focus@</property>
  
@content;noquote@

<if @related_items:rowcount@ gt 0><p>Pages that link to his page:
<multiple name="related_items">
    <a href="@related_items.name@">@related_items.title@</a>
    </multiple>
    </p>
    </if>
<include src="footer" edit_link_p="@edit_link_p@" >