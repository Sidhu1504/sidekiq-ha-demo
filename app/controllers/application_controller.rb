# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_admin, :admin_signed_in?
  helper_method :current_user, :user_signed_in?

  # existing admin methods...
  def current_admin
    @current_admin ||= AdminUser.find_by(id: session[:admin_id]) if session[:admin_id]
  end

  def admin_signed_in?
    current_admin.present?
  end

  def require_admin
    redirect_to login_path, alert: "Please log in" unless admin_signed_in?
  end

  # 👇 new user methods
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def require_user
    redirect_to user_login_path, alert: "Please log in as user" unless user_signed_in?
  end
end

