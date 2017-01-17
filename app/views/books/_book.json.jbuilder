json.extract! book, :id, :title, :cover_image_url, :author, :slug, :created_at, :updated_at
json.url book_url(book, format: :json)
