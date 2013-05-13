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