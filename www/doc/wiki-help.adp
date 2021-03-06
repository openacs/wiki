<master>
<p>Borrowed from <a href="http://mini.net/tcl/14">http://mini.net/tcl/14</a></p><p><b>References:</b></p><ol><li>You can refer to another page by putting its name in square brackets like this: [PAGE].  Note that it is not necessary for the words inside the brackets to have the same case as the original page.  It is, however, necessary for the specific white spacing to be the same.

<li>URLs will automatically be recognized and underlined: <a href="http://your.site/contents.html">http://your.site/contents.html</a>
<li>If you put URLs in square brackets, they'll be shown as a tiny reference [<a href="http://your.site/contents.html">1</a>] instead.  <i>In this situation</i>, the system assumes that any url ending in <b>.jpg</b>, <b>.png</b>, or <b>.gif</b> is an image and displays it inline.
<li>URL methods recognized are:</ol><ul><li><a href="http://www.w3.org/">http://www.w3.org/</a>

<li><a href="ftp://ftp.x.org/">ftp://ftp.x.org/</a>
<li><a href="mailto:user@somehost.com">mailto:user@somehost.com</a>
<li><a href="news:comp.lang.tcl">news:comp.lang.tcl</a></ul><p><b>Adding highlights:</b></p><ul><li>Surround text by pairs of single quotes to make it <i>display in italic</i>
<li>Surround text by triples of single quotes to make it <b>display in bold</b>
<li>Surround text by quintuples of single quotes to make it <i><b>display in bold italic</b></i></ul><p><b>Adding structure to your text:</b></p><ul><li>Lines of text are normally joined, with empty lines used to delineate paragraphs
<li>Lines surrounded by a number of = will be a heading of the number
        of =. For example =Heading 1= ==Heading2== ===Heading 3===
        ====Heading 4====. Only 4 levels are supported.</li>
      <li>Lines starting with three spaces, a &quot;*&quot;, and another space are shown as bulleted items.  The entire item must be entered as one line (possibly wrapping).

<li>Lines starting with three spaces, a &quot;1.&quot;, and another space are shown as a numbered list.  Each numbered item must be entered as one logical line.</ul><ol><li>first numbered bullet
<li>second numbered bullet</ol><ul><li>Lines starting with three spaces, item tag name, &quot;:&quot;, three spaces, and then the item tag body (entered as 1 logical line) are shown as tagged lists.</ul><dl><dt>tag<dd>text<dt>tag<dd>text2</dl><ul><li>All other lines beginning with white space are shown as is - no highlighting, reference generating, or even text wrapping occur.</ul><pre> However, just to keep you on your toes, even in this literal mode, <a href="http://wiki.tcl.tk/">http://wiki.tcl.tk/</a> style URLs are recognized and turned into active links.</pre><p><b>Other features:</b></p><ul><li>Put four or more dashes on a line to get a horizontal separator, like the &quot;----&quot; below:</ul><hr size=1><p><b><i>Note: there's no way YET to undo once changes are saved</b></i> It is however possible to go back in history on <a href="http://mini.net/tclhist/">http://mini.net/tclhist/</a> and fetch old parts of a page that was accidentally lost. Chances are however that changes less than a day old will not yet have made it into this archive.</p><hr size=1><p><i>To get more than one highlight on a single line,</i> you can use returns to break the line in separate physicial lines.  WiKit will concatenate them all into one.  So if you do this (without indents):</p><pre>   I'm going to ''draw''
   your ''attention''.</pre><p>You'll end up with:  I'm going to <i>draw</i> your <i>attention</i>.</p><p>It usually works (for non-pathological cases) just fine if you put everything on a single line. Experiment on the <a href="Graffiti">[</a>Graffiti<a href="Graffiti">]</a> page if you want to check whether anything in particular will work.</p><hr size=1><p><i>Using brackets in your text</i> can be done by doubling them, so <b>[[</b> shows as <b>[</b>.</p><hr size=1>

