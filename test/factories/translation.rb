FactoryGirl.define do
  factory :translation do
    book
    language
    title 'La Rebelion del Atlas'
    cover_image_url 'spanish_atlas_shrugged.jpg'
    publisher 'Grito Sagrado'
    isbn_13 '978-9872095154'
    isbn_10 '0-9578399-1-X'
    translator 'Julio Fernandez-Yanez'
  end
end
