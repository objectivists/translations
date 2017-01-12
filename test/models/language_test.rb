require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test 'valid language can be added' do
    create :language
  end

  test 'required attributes must not be empty' do
    language = Language.new
    assert language.invalid?
    assert language.errors[:name].any?
    assert language.errors[:local_name].any?
    assert language.errors[:slug].any?
  end

  test 'uniq fields cannot be duplicated' do
    create :language
    duplicate_language = Language.new(attributes_for(:language))
    assert duplicate_language.invalid?
    assert duplicate_language.errors[:name].any?
    assert duplicate_language.errors[:local_name].any?
    assert duplicate_language.errors[:slug].any?
  end

  test 'to_param should return the slug' do
    language = build :language
    assert_equal language.slug, language.to_param
  end

  test 'should abort destruction when referenced' do
    translation = create :translation
    language = translation.language

    language.destroy

    assert !language.destroyed?
  end
end
