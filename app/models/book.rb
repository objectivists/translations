class Book < ApplicationRecord
  has_many :translations
  before_destroy :ensure_not_referenced

  validates :title, :author, :slug, presence: true
  validates :title, :slug, uniqueness: true
  validates :cover_image_url, format: {
      with:    %r{\.(gif|jpg|jpeg|png)\Z}i,
      message: 'must be a URL for GIF, JPG/JPEG, or PNG image.'
  }

  def to_param
    slug
  end

  private

  def ensure_not_referenced
    unless translations.empty?
      errors.add(:base, 'Book references translations')
      throw :abort
    end
  end

end
