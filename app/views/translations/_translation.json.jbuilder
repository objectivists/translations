json.extract! translation, :id, :book_id, :language_id, :title, :cover_image_url, :publisher, :translator, :isbn_13,
:isbn_10, :created_at, :updated_at
json.url translation_url(translation, format: :json)
