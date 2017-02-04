# Manages the login functionality for users
class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: 'Invalid username or password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: 'Logged out'
  end
end
