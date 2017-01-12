require 'test_helper'

class TranslationsControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  test 'should get index and display content' do
    translation = create(:translation)

    get translations_url

    assert_select 'h1', 'Translations'

    assert_select '.translation', Translation.count

    assert_select 'th', 'Book'
    assert_select 'th', 'Language'
    assert_select 'th', 'Translated Title'
    assert_select 'th', 'Foreign Cover Image'
    assert_select 'th', 'Publisher'
    assert_select 'th', 'ISBN-13'
    assert_select 'th', 'ISBN-10'
    assert_select 'th', 'Translator'
    assert_select 'th', 'Actions'

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

    assert_select 'a[href=?]', "/admin/translations/#{translation.id}", {:text => 'Show'}
    assert_select 'a[href=?]', "/admin/translations/#{translation.id}/edit", {:text => 'Edit'}
    assert_select 'a[href=?][data-method=delete][data-confirm="Are you sure?"]',
                  "/admin/translations/#{translation.id}", {:text => 'Delete'}
    assert_select 'a[href=?]', '/admin/translations/new', {:text => 'New Translation'}

    assert_response :success
  end

  test 'should get new' do
    get new_translation_url
    assert_select 'h1', 'New Translation'

    assert_form_for_translation

    assert_select 'a[href=?]', '/admin/translations', {:text => 'Back'}
    assert_response :success
  end

  test 'should create translation' do
    translation = attributes_for(:translation)
    translation[:book_id] = create(:book).id
    translation[:language_id] = create(:language).id
    assert_difference('Translation.count') do
      post translations_url, params: {translation: translation}
    end

    assert_redirected_to translation_url(Translation.last)
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

    assert_select 'a[href=?]', "/admin/translations/#{translation.id}/edit", {:text => 'Edit'}
    assert_select 'a[href=?]', '/admin/translations', {:text => 'Back'}

    assert_response :success
  end

  test 'should get edit' do
    translation = create(:translation)

    get edit_translation_url(translation)

    assert_select 'h1', 'Editing Translation'

    assert_form_for_translation

    assert_select 'a[href=?]', '/admin/translations', {:text => 'Back'}
    assert_select 'a[href=?]', "/admin/translations/#{translation.id}", {:text => 'Show'}

    assert_response :success
  end


  test 'should update translation' do
    translation = create(:translation)
    patch translation_url(translation), params: {translation: attributes_for(:translation, title: 'updated-title')}
    assert_redirected_to translation_url(translation)

    get translation_url(translation)

    assert_select 'p', /updated-title/
  end

  test 'should destroy translation' do
    translation = create(:translation)
    assert_difference('Translation.count', -1) do
      delete translation_url(translation)
    end

    assert_redirected_to translations_url
  end

  private

  def assert_form_for_translation
    assert_select '.field', /Book/
    assert_select '.field', /Language/
    assert_select '.field', 'Translated title'
    assert_select '.field', 'Foreign cover image url'
    assert_select '.field', 'Publisher'
    assert_select '.field', 'Isbn 13'
    assert_select '.field', 'Isbn 10'
    assert_select '.field', 'Translator'

    assert_select '.actions [type=submit]'
  end
end
