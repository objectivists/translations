# Displays the admins' homepage
class AdminController < ApplicationController
  before_action :authorize

  def index
  end


  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: 'Please log in to access this page'
    end
  end

end
