require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationTests

  setup do
    @url_to_validate_authentication = books_url
  end

  test 'should get index and display content' do
    book = create(:book)

    get books_url

    assert_select 'h1', 'Books'

    assert_select '.book', Book.count

    assert_select 'th', 'Title'
    assert_select 'th', 'Author'
    assert_select 'th', 'Slug'
    assert_select 'th', 'Actions'

    assert_select 'img[src=?]', "/images/#{book.cover_image_url}"
    assert_select 'td', book.title
    assert_select 'td', book.author
    assert_select 'td', book.slug

    assert_response :success
  end

  test 'index should provide links' do
    book = create(:book)

    get books_url

    assert_select 'a[href=?]', "/admin/books/#{book.slug}", {:text => 'Show'}
    assert_select 'a[href=?]', "/admin/books/#{book.slug}/edit", {:text => 'Edit'}
    assert_select 'a[href=?][data-method=delete][data-confirm="Are you sure?"]',
                  "/admin/books/#{book.slug}", {:text => 'Delete'}
    assert_select 'a[href=?]', '/admin/books/new', {:text => 'New Book'}

    assert_response :success
  end

  test 'should get new' do
    get new_book_url
    assert_select 'h1', 'New Book'

    assert_form_for_book

    assert_select 'a[href=?]', '/admin/books', {:text => 'Back'}
    assert_response :success
  end

  test 'should create book' do
    assert_difference('Book.count') do
      post books_url, params: {book: attributes_for(:book)}
    end

    assert_redirected_to book_url(Book.last)
  end

  test 'should show book' do
    book = create(:book)

    get book_url(book)

    assert_select 'p', /Title/
    assert_select 'p', /Author/
    assert_select 'p', /Slug/
    assert_select 'p', /Cover image/

    assert_select 'img[src=?]', "/images/#{book.cover_image_url}"
    assert_select 'p', /#{book.title}/
    assert_select 'p', /#{book.author}/
    assert_select 'p', /#{book.slug}/

    assert_select 'a[href=?]', "/admin/books/#{book.slug}/edit", {:text => 'Edit'}
    assert_select 'a[href=?]', '/admin/books', {:text => 'Back'}

    assert_response :success
  end

  test 'should get edit' do
    book = create(:book)

    get edit_book_url(book)

    assert_select 'h1', 'Editing Book'

    assert_form_for_book

    assert_select 'a[href=?]', '/admin/books', {:text => 'Back'}
    assert_select 'a[href=?]', "/admin/books/#{book.slug}", {:text => 'Show'}

    assert_response :success
  end


  test 'should update book' do
    book = create(:book)
    patch book_url(book), params: {book: attributes_for(:book, title: 'updated-title')}
    assert_redirected_to book_url(book)

    get book_url(book)

    assert_select 'p', /updated-title/
  end

  test 'should destroy book' do
    book = create(:book)
    assert_difference('Book.count', -1) do
      delete book_url(book)
    end

    assert_redirected_to books_url
  end

  test 'should not destroy book with translation' do
    translation = create :translation
    book = translation.book

    assert_difference('Book.count', 0) do
      delete book_url(book)
    end

    assert_redirected_to books_url
  end

  private
  
  def assert_form_for_book
    assert_select '.field', 'Title'
    assert_select '.field', 'Cover image url'
    assert_select '.field', 'Author'
    assert_select '.field', 'Slug'

    assert_select '.actions [type=submit]'
  end
end
