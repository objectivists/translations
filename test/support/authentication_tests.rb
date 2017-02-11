require 'support/authentication_test_support'

# Tests that should be included for any authenticated controller.
module AuthenticationTests
  extend ActiveSupport::Concern
  include FactoryGirl::Syntax::Methods
  include AuthenticationTestSupport

  # Tests require controllers to set '@url_to_validate_authentication'.
  included do
    setup do
      # Allows controllers to run tests against authenticated pages
      @user = create_logged_in_user
    end

    test 'no access when logged out' do
      logout_user
      get @url_to_validate_authentication
      assert_redirected_to login_url
    end
  end
end
