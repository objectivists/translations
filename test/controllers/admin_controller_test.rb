require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  include AdminBaseTests

  setup do
    @url_to_validate = admin_url
  end

  test 'should get index' do
    get admin_url
    assert_response :success
    assert_select 'a[href=?]', '/admin/books', {:text => 'Books'}
  end
end
