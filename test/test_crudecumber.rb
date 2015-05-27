require 'minitest/autorun'
require 'crudecumber'

class CrudecumberTest < MiniTest::Unit::TestCase
  def test_english_hello
    assert_equal "hello Crudecumber",
      Crudecumber.hi("english")
  end

  def test_any_hello
    assert_equal "hello Crudecumber",
      Crudecumber.hi("ruby")
  end

  def test_spanish_hello
    assert_equal "hola Crudecumber",
      Crudecumber.hi("spanish")
  end
end
