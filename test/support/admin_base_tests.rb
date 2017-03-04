require 'support/authentication_test_support'

# Tests that should be included for any admin related controller.
module AdminBaseTests
  extend ActiveSupport::Concern
  include FactoryGirl::Syntax::Methods
  include AuthenticationTestSupport

  # Tests require controllers to set '@url_to_validate'.
  included do
    setup do
      # Allows controllers to run tests against authenticated pages
      @user = create_logged_in_user
    end

    test 'no access when logged out' do
      logout_user
      get @url_to_validate
      assert_redirected_to login_url
    end

    test 'renders admin layout' do
      get @url_to_validate
      assert_template layout: 'layouts/admin'
    end

    test 'admin layout' do
      get @url_to_validate
      assert_select '.navbar', /Admin/
      assert_select '.active', 1
      assert_select 'a[href=?]', '/admin/books'
      assert_select 'a[href=?]', '/admin/languages'
      assert_select 'a[href=?]', '/admin/translations'
      assert_select 'a[href=?]', '/admin/users'
      assert_select 'a[href=?]', '/logout'
    end

  end
end
