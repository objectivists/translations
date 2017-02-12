# Supported for authentication-based tests.
module AuthenticationTestSupport
  def create_logged_in_user
    user = create :user
    log_in_user user
    user
  end

  def log_in_user(user)
    post login_url, params: {email: user.email, password: 'password'}
  end

  def logout_user
    delete logout_url
  end
end
