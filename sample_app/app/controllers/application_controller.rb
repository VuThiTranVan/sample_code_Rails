class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def valid_info object
    render file: "public/404.html", status: 404, layout: true unless object
  end

  private

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?
      store_location
      flash[:danger] = t "users.edit.required_login_msg"
      redirect_to login_url
  end
end
