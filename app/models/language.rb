class Language < ApplicationRecord
  has_many :translations
  before_destroy :ensure_not_referenced

  validates :name, :local_name, :slug, presence: true
  validates :name, :local_name, :slug, uniqueness: true

  def to_param
    slug
  end

  def ensure_not_referenced
    unless translations.empty?
      errors.add(:base, 'Language references translations')
      throw :abort
    end
  end
end
