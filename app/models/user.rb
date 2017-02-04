# Users act as the administrators of the site
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  # Very loose since legal email format varies wildly.
  validates :email, format: {
      with: %r{@},
      message: 'please enter a valid email address'
  }
end
