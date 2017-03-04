require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include AdminBaseTests

  setup do
    @url_to_validate = books_url
  end

  test 'should get index and display content' do
    book = create(:book)

    get books_url

    assert_select 'h1', 'Books'

    assert_select '.book', Book.count

    assert_select 'th', 'Title'
    assert_select 'th', 'Author'
    assert_select 'th', 'Slug'

    assert_select 'img[src=?]', "/images/#{book.cover_image_url}"
    assert_select 'td', book.title
    assert_select 'td', book.author
    assert_select 'td', book.slug

    assert_response :success
  end

  test 'index should provide links' do
    book = create(:book)

    get books_url

    assert_select 'a[href=?]', "/admin/books/#{book.slug}/edit"
    assert_select 'a[href=?][data-method=delete][data-confirm="Are you sure?"]', "/admin/books/#{book.slug}"
    assert_select 'a[href=?]', '/admin/books/new'

    assert_response :success
  end

  test 'should get new' do
    get new_book_url
    assert_select '.panel-title', 'New book'

    assert_form_for_book

    assert_response :success
  end

  test 'should create book' do
    assert_difference('Book.count') do
      post books_url, params: {book: attributes_for(:book)}
    end

    assert_redirected_to books_url
    assert_not_nil flash[:notice]
  end

  test 'should get edit' do
    book = create(:book)

    get edit_book_url(book)

    assert_select '.panel-title', 'Edit book'

    assert_form_for_book

    assert_select 'a[href=?]', '/admin/books'

    assert_response :success
  end

  test 'should update book' do
    book = create(:book)
    patch book_url(book), params: {book: attributes_for(:book, title: 'updated-title')}
    assert_redirected_to books_url

    get book_url(book)

    assert_select 'p', /updated-title/
    assert_not_nil flash[:notice]
  end

  test 'should delete book' do
    book = create(:book)
    assert_difference('Book.count', -1) do
      delete book_url(book)
    end

    assert_redirected_to books_url
  end

  test 'should not delete book with translation' do
    translation = create :translation
    book = translation.book

    assert_difference('Book.count', 0) do
      delete book_url(book)
    end

    assert_redirected_to books_url
  end

  test 'should display notice when deleted' do
    book = create(:book)
    delete book_url(book)

    assert_not_nil flash[:notice]
    assert_nil flash[:alert]

    get books_url

    assert_select '.alert-info', true
    assert_select '.alert-warning', false
  end

  test 'should display alert when delete failed' do
    translation = create :translation
    book = translation.book
    delete book_url(book)

    assert_nil flash[:notice]
    assert_not_nil flash[:alert]

    get books_url

    assert_select '.alert-info', false
    assert_select '.alert-warning', true
  end

  private
  
  def assert_form_for_book
    assert_select '.control-label', 'Title'
    assert_select '.control-label', 'Image'
    assert_select '.control-label', 'Author'
    assert_select '.control-label', 'Slug'

    assert_select 'input[type="submit"]'
  end
end
