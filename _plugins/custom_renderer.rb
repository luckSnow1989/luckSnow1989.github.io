require 'kramdown'
# markdown 将超链接转为a标签时，添加属性。
class CustomRenderer < Kramdown::Converter::Html
  def convert_a(el, indent)
    attrs = el.attr.dup
    attrs['target'] = '_blank'
    attrs['rel'] = 'noopener noreferrer'
    super(el, indent, attrs)
  end
end

Kramdown::Converter.add('custom_html', CustomRenderer)