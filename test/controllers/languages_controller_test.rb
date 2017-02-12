require 'test_helper'

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationTests

  setup do
    @url_to_validate_authentication = languages_url
  end

  test 'should get index and display content' do
    language = create(:language)

    get languages_url

    assert_select 'h1', 'Languages'

    assert_select '.language', Language.count

    assert_select 'th', 'Name'
    assert_select 'th', 'Local name'
    assert_select 'th', 'Slug'
    assert_select 'th', 'Actions'

    assert_select 'td', language.name
    assert_select 'td', language.local_name
    assert_select 'td', language.slug

    assert_response :success
  end

  test 'index should provide links' do
    language = create(:language)

    get languages_url

    assert_select 'a[href=?]', "/admin/languages/#{language.slug}", {:text => 'Show'}
    assert_select 'a[href=?]', "/admin/languages/#{language.slug}/edit", {:text => 'Edit'}
    assert_select 'a[href=?][data-method=delete][data-confirm="Are you sure?"]',
                  "/admin/languages/#{language.slug}", {:text => 'Delete'}
    assert_select 'a[href=?]', '/admin/languages/new', {:text => 'New Language'}

    assert_response :success
  end

  test 'should get new' do
    get new_language_url
    assert_select 'h1', 'New Language'

    assert_form_for_language

    assert_select 'a[href=?]', '/admin/languages', {:text => 'Back'}
    assert_response :success
  end

  test 'should create language' do
    assert_difference('Language.count') do
      post languages_url, params: {language: attributes_for(:language)}
    end

    assert_redirected_to language_url(Language.last)
  end

  test 'should show language' do
    language = create(:language)

    get language_url(language)

    assert_select 'p', /Name/
    assert_select 'p', /Local name/
    assert_select 'p', /Slug/

    assert_select 'p', /#{language.name}/
    assert_select 'p', /#{language.local_name}/
    assert_select 'p', /#{language.slug}/

    assert_select 'a[href=?]', "/admin/languages/#{language.slug}/edit", {:text => 'Edit'}
    assert_select 'a[href=?]', '/admin/languages', {:text => 'Back'}

    assert_response :success
  end

  test 'should get edit' do
    language = create(:language)

    get edit_language_url(language)

    assert_select 'h1', 'Editing Language'

    assert_form_for_language

    assert_select 'a[href=?]', '/admin/languages', {:text => 'Back'}
    assert_select 'a[href=?]', "/admin/languages/#{language.slug}", {:text => 'Show'}

    assert_response :success
  end

  test 'should update language' do
    language = create(:language)
    patch language_url(language), params: {language: attributes_for(:language, name: 'updated-name')}
    assert_redirected_to language_url(language)

    get language_url(language)

    assert_select 'p', /updated-name/
  end

  test 'should destroy language' do
    language = create(:language)
    assert_difference('Language.count', -1) do
      delete language_url(language)
    end

    assert_redirected_to languages_url
  end

  test 'should not destroy language with translation' do
    translation = create :translation
    language = translation.language

    assert_difference('Language.count', 0) do
      delete language_url(language)
    end

    assert_redirected_to languages_url
  end

  private

  def assert_form_for_language
    assert_select '.field', 'Name'
    assert_select '.field', 'Local name'
    assert_select '.field', 'Slug'

    assert_select '.actions [type=submit]'
  end
end
