class Translation < ApplicationRecord
  belongs_to :book
  belongs_to :language

  validates :title, :cover_image_url, :publisher, presence: true
  validates :title, :isbn_13, :isbn_10, uniqueness: true
  validates :cover_image_url, format: {
      with: %r{\.(gif|jpg|jpeg|png)\Z}i,
      message: 'must be a URL for GIF, JPG/JPEG, or PNG image.'
  }

end
