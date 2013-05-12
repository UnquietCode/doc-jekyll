module Jekyll
  class ProcessContent < Generator

    def generate(site)
      
      site.pages.each do |page|
        sections = parse_chapter(page.content.split(/\r?\n/))

        # TODO markdownify, highlightification

        # pull out the first section, which might be introductory
        first_section = sections[0] || nil

        if !first_section.nil? && first_section['code'].nil? && first_section['title'].nil?
          sections = sections[1..sections.length]
          page.content = first_section['comment']
        else
          page.content = ""
        end

        unless sections.length == 0
          page.data['sections'] = sections
        end
      end
    end

    private

    def join_lines(lines)
      string = ""

      lines.each_with_index do |line, idx|
        if idx != 0
          string << "\n"
        end

        string << line
      end

      return string
    end

    def parse_section(lines)
      splits = []

      lines.each_with_index do |line, index|
        line = line.strip

        if line.start_with?("---")
          splits.push(index)
        end
      end

      comment = code = nil

      case splits.length
        when 0
          comment = join_lines(lines)
          comment = nil if comment.strip.empty?

        when 1
          comment = join_lines(lines[0, splits[0]])
          comment = nil if comment.strip.empty?

          code = join_lines(lines[splits[0]+1, lines.length])
          code = nil if code.strip.empty?
        else
          # TODO ruby exception for this?
          raise "ParseException: Too many splits."
      end

      return [comment, code]
    end

    def parse_title(line)
      title = line.strip.match(/(={3,})(.*?)(===?.*)/)
      title.nil? ? nil : title[2].strip      
    end

    def parse_chapter(file)
      sections = []
      lines = []

      # subroutine to handle a new section
      process_a_section = lambda {
        section = make_section(lines)
        sections.push(section) unless section.nil?
        lines = []
      }

      file.each do |line|
        line = line.strip

        if line.start_with?("===")
          process_a_section.call
        end

        lines.push(line)
      end

      process_a_section.call
      return sections
    end

    def make_section(lines)
      return nil if lines.length == 0
      title = parse_title(lines[0])

      # if no title line, then assume it's part of the content
      unless title.nil?
        lines = lines[1..lines.length]
      end

      title = nil if !title.nil? && title.empty?
      comment, code = parse_section(lines)

      if title.nil? && comment.nil? and code.nil?
        nil
      else
        { 'title' => title, 'comment' => comment, 'code' => code }
      end
    end
  end
end