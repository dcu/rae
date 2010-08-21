require 'mechanize'

if RUBY_VERSION < '1.9'
  $KCODE = 'u'
end

class Rae
  def initialize
  end

  def search(word, bus = 3)
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    page = agent.get 'http://buscon.rae.es/draeI/html/cabecera.htm'

    form = page.forms.first

    form['TIPO_BUS'] = bus
    form['LEMA'] = word

    page = agent.submit(form, form.buttons.first)

    parse_page(page, word)
  end

  protected
  def parse_page(page, word)
    definitions = []
    subdefinition = nil
    page.parser.css('p').each_with_index do |l, index|
      if l.content.to_s.strip =~ /La palabra #{Regexp.escape(word)} no/
        links = page.links_with(:href => /\?LEMA\=/)
        if link = links.first
          word = link.text.strip
          page = link.click
          return parse_page(page, word)
        end
      else
        definition, subdefinition = parse_definition(l, subdefinition, word)
        definitions << definition if definition
      end
    end

    definitions
  end

  def parse_definition(l, subdefinition, word)
    definition = l.content.to_s.strip
    if definition =~ /\d+\.\s+(.+)/
      definition = $1
      if subdefinition
        definition = "#{subdefinition} -> #{definition}"
      end
    elsif definition =~ /\~/
      subdefinition = definition.sub("~", word).strip
      definition = nil
    else
      definition = nil
    end

    [definition, subdefinition]
  end
end
