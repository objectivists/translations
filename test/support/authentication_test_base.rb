# Base test support and testing for any authenticated controller.
module AuthenticationTestBase
  extend ActiveSupport::Concern
  include FactoryGirl::Syntax::Methods

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

  def create_logged_in_user
    user = create(:user)
    post login_url, params: {email: user.email, password: 'password'}
    user
  end

  def logout_user
    delete logout_url
  end

end
