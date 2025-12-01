class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "✅ Logged in successfully!"
    else
      flash.now[:alert] = "❌ No account found with these credentials. Please create an account."
      render :new, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to user_login_path, notice: "✅ Logged out successfully."
  end
end

