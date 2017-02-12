require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods
  include AuthenticationTestSupport

  test 'should get new' do
    get login_url

    assert_select 'legend', 'Please Log In'

    assert_select 'label', 'Email:'
    assert_select 'label', 'Password:'

    assert_select 'input[type=submit]'
  end

  test 'should create session' do
    create_logged_in_user
    assert_redirected_to admin_url
  end

  test 'should fail to create session for invalid password' do
    user = create(:user)
    post login_url, params: {email: user.email,  password: 'wrong_password'}
    assert_redirected_to login_url
  end

  test 'should fail to create session for non-existing user' do
    user = create(:user)
    post login_url, params: {email: 'new' + user.email,  password: 'password'}
    assert_redirected_to login_url
  end

  test 'should destroy session' do
    logout_user
    assert_redirected_to login_url

    get admin_url
    assert_redirected_to login_url
  end

end
