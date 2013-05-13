Doc Jekyll is...
------------
* a documentation tool
* based on the templates used in [Docco](http://jashkenas.github.io/docco/)
* a [Jekyll](http://jekyllrb.com/) project, ready to compile


How to use:
-------------
0. Add files to your project's directory (next to the 'alpha.md' and 'beta.md' files).
1. Adjust your _config.yml. Ensure that 'language' is set appropriately for your code snippets.
2. Make sure their templates are set to 'docco'.
3. Make sure their styles are set to one of 'linear', 'paralell', or 'classic' (as in Docco).
4. Declare your code and comment sections in your files after the YAML front matter.

Section Notation
---------------
* Sections are comprised of an optional _title_, required _commentary_, and optional _code_.
* The first section in a document is considered the _introduction_ if it contains no code.
* Sections are separated by a line which starts with at least 3 equal signs, '==='.
* A section may contain a title inline, such as '===== Section One ===' or just '==== Section One'.
* Comment and code are separated by a line which starts with at least 3 dashes, '---'.
* The last section does not require a trailing divider ('===').
* See [beta.md](https://raw.github.com/UnquietCode/doc-jekyll/master/beta.md) for a richer example. (view the raw file)

## Thanks!
Docco is from Jeremy Ashkenas **//** Jekyll is from Tom Preston-Werner  
Doc Jekyll is from [Ben Fagin](https://github.com/UnquietCode)
  
&nbsp;  
Peace, love, and code.
