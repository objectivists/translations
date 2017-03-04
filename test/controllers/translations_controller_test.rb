require 'test_helper'

class TranslationsControllerTest < ActionDispatch::IntegrationTest
  include AdminBaseTests

  setup do
    @url_to_validate = translations_url
  end

  test 'should get index and display content' do
    translation = create(:translation)

    get translations_url

    assert_select 'h1', 'Translations'

    assert_select '.translation', Translation.count

    assert_select 'th', 'Book'
    assert_select 'th', 'Language'
    assert_select 'th', 'Translated Title'
    assert_select 'th', 'Cover'
    assert_select 'th', 'Publisher'
    assert_select 'th', 'ISBN-13'
    assert_select 'th', 'ISBN-10'
    assert_select 'th', 'Translator'

    assert_select 'img[src=?]', "/images/#{translation.cover_image_url}"
    assert_select 'td', translation.book.title
    assert_select 'td', translation.language.name
    assert_select 'td', translation.title
    assert_select 'td', translation.publisher
    assert_select 'td', translation.isbn_13
    assert_select 'td', translation.isbn_10
    assert_select 'td', translation.translator

    assert_response :success
  end

  test 'index should provide links' do
    translation = create(:translation)

    get translations_url

    assert_select 'a[href=?]', "/admin/translations/#{translation.id}/edit"
    assert_select 'a[href=?][data-method=delete][data-confirm="Are you sure?"]',
                  "/admin/translations/#{translation.id}"
    assert_select 'a[href=?]', '/admin/translations/new'

    assert_response :success
  end

  test 'should get new' do
    get new_translation_url

    assert_form_for_translation

    assert_select 'a[href=?]', '/admin/translations'
    assert_response :success
  end

  test 'should create translation' do
    translation = attributes_for(:translation)
    translation[:book_id] = create(:book).id
    translation[:language_id] = create(:language).id
    assert_difference('Translation.count') do
      post translations_url, params: {translation: translation}
    end

    assert_redirected_to translations_url
    assert_not_nil flash[:notice]
  end

  test 'should show translation' do
    translation = create(:translation)

    get translation_url(translation)

    assert_select 'p', /Book/
    assert_select 'p', /Language/
    assert_select 'p', /Translated title/
    assert_select 'p', /Publisher/
    assert_select 'p', /ISBN-13/
    assert_select 'p', /ISBN-10/
    assert_select 'p', /Translator/
    assert_select 'p', /Foreign cover image/

    assert_select 'img[src=?]', "/images/#{translation.cover_image_url}"
    assert_select 'p', /#{translation.book.title}/
    assert_select 'p', /#{translation.language.name}/
    assert_select 'p', /#{translation.title}/
    assert_select 'p', /#{translation.publisher}/
    assert_select 'p', /#{translation.isbn_13}/
    assert_select 'p', /#{translation.isbn_10}/
    assert_select 'p', /#{translation.translator}/

    assert_select 'a[href=?]', "/admin/translations/#{translation.id}/edit"
    assert_select 'a[href=?]', '/admin/translations'

    assert_response :success
  end

  test 'should get edit' do
    translation = create(:translation)

    get edit_translation_url(translation)

    assert_form_for_translation

    assert_response :success
  end


  test 'should update translation' do
    translation = create(:translation)
    patch translation_url(translation), params: {translation: attributes_for(:translation, title: 'updated-title')}
    assert_redirected_to translations_url

    get translation_url(translation)

    assert_select 'p', /updated-title/
    assert_not_nil flash[:notice]
  end

  test 'should delete translation' do
    translation = create(:translation)
    assert_difference('Translation.count', -1) do
      delete translation_url(translation)
    end

    assert_redirected_to translations_url
  end

  test 'should display notice when deleted' do
    translation = create(:translation)
    delete translation_url(translation)

    assert_not_nil flash[:notice]
    assert_nil flash[:alert]

    get translations_url

    assert_select '.alert-info', true
    assert_select '.alert-warning', false
  end

  private

  def assert_form_for_translation
    assert_select '.control-label', /Book/
    assert_select '.control-label', /Language/
    assert_select '.control-label', 'Translated title'
    assert_select '.control-label', 'Image'
    assert_select '.control-label', 'Publisher'
    assert_select '.control-label', 'Isbn 13'
    assert_select '.control-label', 'Isbn 10'
    assert_select '.control-label', 'Translator'

    assert_select 'input[type=submit]'
  end
end
