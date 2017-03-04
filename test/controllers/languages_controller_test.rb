require 'test_helper'

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  include AdminBaseTests

  setup do
    @url_to_validate = languages_url
  end

  test 'should get index and display content' do
    language = create(:language)

    get languages_url

    assert_select 'h1', 'Languages'

    assert_select '.language', Language.count

    assert_select 'th', 'Name'
    assert_select 'th', 'Translated name'
    assert_select 'th', 'Slug'

    assert_select 'td', language.name
    assert_select 'td', language.local_name
    assert_select 'td', language.slug

    assert_response :success
  end

  test 'index should provide links' do
    language = create(:language)

    get languages_url

    assert_select 'a[href=?]', "/admin/languages/#{language.slug}/edit"
    assert_select 'a[href=?][data-method=delete][data-confirm="Are you sure?"]', "/admin/languages/#{language.slug}"
    assert_select 'a[href=?]', '/admin/languages/new'

    assert_response :success
  end

  test 'should get new' do
    get new_language_url

    assert_form_for_language

    assert_response :success
  end

  test 'should create language' do
    assert_difference('Language.count') do
      post languages_url, params: {language: attributes_for(:language)}
    end

    assert_redirected_to languages_url
    assert_not_nil flash[:notice]
  end

  test 'should get edit' do
    language = create(:language)

    get edit_language_url(language)

    assert_form_for_language

    assert_response :success
  end

  test 'should update language' do
    language = create(:language)
    patch language_url(language), params: {language: attributes_for(:language, name: 'updated-name')}
    assert_redirected_to languages_url

    get language_url(language)

    assert_select 'p', /updated-name/
    assert_not_nil flash[:notice]
  end

  test 'should delete language' do
    language = create(:language)
    assert_difference('Language.count', -1) do
      delete language_url(language)
    end

    assert_redirected_to languages_url
  end

  test 'should not delete language with translation' do
    translation = create :translation
    language = translation.language

    assert_difference('Language.count', 0) do
      delete language_url(language)
    end

    assert_redirected_to languages_url
  end

  test 'should display notice when deleted' do
    language = create(:language)
    delete language_url(language)

    assert_not_nil flash[:notice]
    assert_nil flash[:alert]

    get languages_url

    assert_select '.alert-info', true
    assert_select '.alert-warning', false
  end

  test 'should display alert when delete failed' do
    translation = create :translation
    language = translation.language
    delete language_url(language)

    assert_nil flash[:notice]
    assert_not_nil flash[:alert]

    get languages_url

    assert_select '.alert-info', false
    assert_select '.alert-warning', true
  end

  private

  def assert_form_for_language
    assert_select '.control-label', 'Name'
    assert_select '.control-label', 'Translated name'
    assert_select '.control-label', 'Slug'

    assert_select 'input[type=submit]'
  end
end
