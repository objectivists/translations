require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationTestBase

  setup do
    @url_to_validate_authentication = admin_url
  end

  test 'should get index' do
    get admin_url
    assert_response :success
    assert_select 'a[href=?]', '/admin/books', {:text => 'Books'}
  end
end
