class Crudecumber
  def self.hi(language = "english")
    translator = Translator.new(language)
    translator.hi
  end
end

require 'crudecumber/translator'
