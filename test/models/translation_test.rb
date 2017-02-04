require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  
  test 'valid translation can be added' do
    create :translation
  end

  test 'required attributes must not be empty' do
    translation = Translation.new
    assert translation.invalid?
    assert translation.errors[:book].any?
    assert translation.errors[:language].any?
  end

  test 'uniq fields cannot be duplicated' do
    create :translation
    duplicate_translation = Translation.new(attributes_for(:translation))
    assert duplicate_translation.invalid?
    assert duplicate_translation.errors[:title].any?
    assert duplicate_translation.errors[:isbn_10].any?
    assert duplicate_translation.errors[:isbn_13].any?
  end

  test 'valid cover image url' do
    valid = %w(pic.gif http://a-b/c.d/pic.jpg PIC.JPEG a.pic.png)
    invalid = %w(pic.gif.zip pic pic.zip)

    translation = build :translation

    valid.each do |url|
      translation.cover_image_url = url
      assert translation.valid?, "#{url} shouldn't be invalid"
    end

    invalid.each do |url|
      translation.cover_image_url = url
      assert translation.invalid?, "#{url} should be invalid"
    end
  end

end
