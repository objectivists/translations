require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  test 'should get index' do
    get books_url
    assert_response :success
  end

  test 'should get new' do
    get new_book_url
    assert_response :success
  end

  test 'should create book' do
    assert_difference('Book.count') do
      post books_url, params: {book: attributes_for(:book)}
    end

    assert_redirected_to book_url(Book.last)
  end

  test 'should show book' do
    get book_url(create(:book))
    assert_response :success
  end

  test 'should get edit' do
    get edit_book_url(create(:book))
    assert_response :success
  end

  test 'should update book' do
    book = create(:book)
    patch book_url(book), params: {book: attributes_for(:book)}
    assert_redirected_to book_url(book)
  end

  test 'should destroy book' do
    book = create(:book)
    assert_difference('Book.count', -1) do
      delete book_url(book)
    end

    assert_redirected_to books_url
  end
end
