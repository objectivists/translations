class Book < ApplicationRecord
  validates :title, :author, :slug, :cover_image_url, presence: true
  validates :title, :slug, uniqueness: true
  validates :cover_image_url, format: {
      with:    %r{\.(gif|jpg|jpeg|png)\Z}i,
      message: 'must be a URL for GIF, JPG/JPEG, or PNG image.'
  }
end
