class SessionsController < ApplicationController
  def new
  end

  def create
    admin = AdminUser.find_by(email: params[:email])

    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id   # ✅ THIS LINE IS CRITICAL
      redirect_to admin_dashboard_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unauthorized
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end

