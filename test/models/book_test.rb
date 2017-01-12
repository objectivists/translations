require 'test_helper'

class BookTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test 'valid book can be added' do
    create(:book)
  end

  test 'required attributes must not be empty' do
    book = Book.new
    assert book.invalid?
    assert book.errors[:title].any?
    assert book.errors[:author].any?
    assert book.errors[:slug].any?
    assert book.errors[:cover_image_url].any?
  end

  test 'uniq fields cannot be duplicated' do
    create(:book)
    duplicate_book = Book.new(attributes_for(:book))
    assert duplicate_book.invalid?
    assert duplicate_book.errors[:title].any?
    assert duplicate_book.errors[:slug].any?
  end

  test 'valid cover image url' do
    valid = %w(pic.gif http://a-b/c.d/pic.jpg PIC.JPEG a.pic.png)
    invalid = %w(pic.gif.zip pic pic.zip)

    valid.each do |url|
      assert build(:book, cover_image_url: url).valid?, "#{url} shouldn't be invalid"
    end

    invalid.each do |url|
      assert build(:book, cover_image_url: url).invalid?, "#{url} should be invalid"
    end
  end

  test 'to_param should return the slug' do
    book = build(:book)
    assert_equal book.slug, book.to_param
  end

  test 'should abort destruction when referenced' do
    translation = create :translation
    book = translation.book

    book.destroy

    assert !book.destroyed?
  end

end
