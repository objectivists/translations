require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationTests

  setup do
    @url_to_validate_authentication = users_url
  end

  test 'should get index and display content' do
    get users_url

    assert_select 'h4', 'Admins'

    assert_select '.user', User.count

    assert_select 'th', 'Email'

    assert_select 'td', @user.email

    assert_response :success
  end

  test 'index should provide links' do
    get users_url

    assert_select 'a[href=?]', "/admin/users/#{@user.id}/edit"
    assert_select 'a[href=?][data-method=delete][data-confirm="Are you sure?"]', "/admin/users/#{@user.id}"
    assert_select 'a[href=?]', '/admin/users/new'

    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_select '.panel-title', 'New user'

    assert_form_for_user

    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: {user: {email: 'new' + @user.email, password: 'password'}}
    end

    assert_redirected_to users_url
  end

  test 'should get edit' do
    get edit_user_url(@user)

    assert_select '.panel-title', 'Edit user'

    assert_form_for_user

    assert_select 'a[href=?]', '/admin/users'

    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user), params: {user: {email: 'updated-email@mail.com', password: 'password'}}
    assert_redirected_to users_url

    get user_url(@user)

    assert_select 'p', /updated-email@mail.com/
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  private

  def assert_form_for_user
    assert_select '.control-label', 'Email'
    assert_select '.control-label', 'Password'

    assert_select 'input[type="submit"]'
  end
end
