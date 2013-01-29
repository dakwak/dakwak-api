require 'dakwak-api'
require 'test/unit'

class WrapperTest < Test::Unit::TestCase

  # add your apikey here
  APIKEY = ""

  def test_must_return_error_when_apikey_is_empty
    wrapper = Dakwak::Api::Wrapper.new("123456-invalid-key")
    assert({"error"=>"invalid apikey"}.eql?(wrapper.get_translation("hola", "ar"))) 
  end
  def test_must_return_error_when_lang_is_invalid
    wrapper = Dakwak::Api::Wrapper.new(APIKEY)
    assert({"error"=>"lang is not valid or supported"}.eql?(wrapper.get_translation("hola", "xyz"))) 
  end
  def test_get_translation_must_return_empty_when_phrase_is_not_translated
    wrapper = Dakwak::Api::Wrapper.new(APIKEY) 
    #phrases that is unlikely to be translated (is in db, but not translated)
    assert_equal("", wrapper.get_translation("dinosaurs", "es")["translation"])
  end
  def test_get_translation_must_return_error_when_phrase_does_not_exist
    wrapper = Dakwak::Api::Wrapper.new(APIKEY) 
    #phrases that is unlikely to be in the db
    assert({"error"=>"phrase was not found in the database"}.eql?(wrapper.get_translation("shooot", "es")))
  end

end