class Translator
  def initialize(language)
    @language = language
  end

  def hi
    case @language
    when "spanish"
      "hola Crudecumber"
    else
      "hello Crudecumber"
    end
  end
end
