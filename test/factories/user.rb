FactoryGirl.define do
  factory :user do
    email 'user@email.com'
    password_digest BCrypt::Password.create('password')
  end
end
