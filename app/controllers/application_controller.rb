class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_logged_in_user

  def set_logged_in_user
    @logged_in_user = User.find_by(id: session[:logged_in_user_id])
  end
end
