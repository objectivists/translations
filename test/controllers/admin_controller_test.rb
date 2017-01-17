require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admin_url
    assert_response :success
    assert_select 'a[href=?]', '/admin/books', {:text => 'Books'}
  end
end
