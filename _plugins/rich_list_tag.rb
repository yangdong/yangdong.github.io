module Jekyll

  class RichListTag < Liquid::Tag
    def initialize(tag_name, number, tokens)
      super
      @number = number
    end

    def render(context)
      "<section class=\"rich-list\">#{@number}</section>"
    end
  end
end

Liquid::Template.register_tag('richlist', Jekyll::RichListTag)