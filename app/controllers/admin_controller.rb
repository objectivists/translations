# Displays the admins' homepage
class AdminController < ApplicationController
  before_action :authorize

  def index
  end


  protected

  def authorize
    unless @logged_in_user
      redirect_to login_url, notice: 'Please log in to access this page'
      session[:redirect_url] = request.original_url
    end
  end

end
