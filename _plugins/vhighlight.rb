# monkey-patch for Jekyll's built-in highlight tag which does the following:
#
#   1. inserts the documentation language from the site _config.yml
#   2. changes <pre><code> blocks to remove the <code> tag
#
module Jekyll
  module Tags
	class HighlightBlock	
		old_init = instance_method(:initialize)

		define_method(:initialize) do |tag_name, markup, tokens|
  			lang = Jekyll.configuration({})['language']  			
  			old_init.bind(self).(tag_name, "#{lang} #{markup}", tokens)
  		end

  		def add_code_tags(code, lang)
	        code = code.sub(/<pre>/,'<pre class="' + lang + '">')
	    end
    end
  end
end