module Jekyll
  class TargetBlankGenerator < Generator
    safe true
    priority :low

    def generate(site)
      site.pages.each do |page|
        next unless page.output_ext == '.html'
        doc = Nokogiri::HTML.parse(page.content)
        doc.css('a').each do |a|
          a.set_attribute('target', '_blank')
          a.set_attribute('rel', 'noopener noreferrer')
        end
        page.content = doc.to_html
      end
    end
  end
end