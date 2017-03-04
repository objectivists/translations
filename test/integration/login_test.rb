require 'test_helper'

# Integration tests related to authentication behavior
class LoginTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods
  include AuthenticationTestSupport

  # If a user is trying to login:
  # 1. They should be redirected from the page they were trying to access to the login page.
  # 2. They should be shown the login page until they enter a valid user name and password.
  # 3. Once they enter a valid user name and password, the user should be redirected to the page originally
  #   trying to be reached. If the user landed directly on the login page and were not redirected, logging in
  #   successfully should redirect to the admin page.
  #
  # This test targets the logic for #3 as it is implemented across multiple controllers. The other logic is more
  # thoroughly tested in the specific controller tests.
  test 'user is redirected correctly' do
    get translations_url
    assert_redirected_to login_url

    user = create_logged_in_user

    # The redirect should be the url the user was trying to get to.
    assert_redirected_to translations_url

    logout_user
    assert_redirected_to login_url

    log_in_user user
    # Since the user has not tried to access any authorized pages, the redirect should be the default page.
    assert_redirected_to books_url
  end
end
