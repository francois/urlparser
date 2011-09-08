module UrlParser
  autoload :Parser, "urlparser/parser"

  def self.parse(str)
    Parser.new.parse(str)
  end
end
