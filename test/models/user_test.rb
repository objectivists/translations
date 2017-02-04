require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test 'valid user can be added' do
    create(:user)
  end

  test 'required attributes must not be empty' do
    user = User.new
    assert user.invalid?
    assert user.errors[:email].any?
    assert user.errors[:password_digest].any?
  end

  test 'uniq fields cannot be duplicated' do
    create(:user)
    duplicate_user = User.new(attributes_for(:user))
    assert duplicate_user.invalid?
    assert duplicate_user.errors[:email].any?
  end

  test 'valid cover image url' do
    valid = %w(@com example@mail.com example@)
    invalid = %w(mail mail.com)

    valid.each do |email|
      assert build(:user, email: email).valid?, "#{email} shouldn't be invalid"
    end

    invalid.each do |email|
      assert build(:user, email: email).invalid?, "#{email} should be invalid"
    end
  end
end
