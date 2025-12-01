# app/controllers/home_controller.rb
class HomeController < ApplicationController
  before_action :require_user
  def index
    @user = current_user || User.new
    @results = []

    if user_signed_in?
      @jobs = JobLog.includes(:user)
                    .where(user_id: current_user.id)
                    .order(created_at: :desc)
                    .limit(10)
    else
      @jobs = []
    end
  end

  def trigger
    # user must be logged in to run job
    unless user_signed_in?
      redirect_to user_login_path, alert: "Please log in to run jobs"
      return
    end

    # optional: update profile from form each time
    current_user.update!(user_params)

    DemoJob.perform_later(current_user.id)

    redirect_to root_path, notice: "Job triggered for your account!"
  end

  def search
    @user = current_user || User.new
    query = params[:query]

    if user_signed_in?
      @results = User.where(id: current_user.id)
                     .where("name ILIKE :q OR email ILIKE :q OR department ILIKE :q", q: "%#{query}%")
    else
      @results = []
    end

    if user_signed_in?
      @jobs = JobLog.includes(:user)
                    .where(user_id: current_user.id)
                    .order(created_at: :desc)
                    .limit(10)
    else
      @jobs = []
    end

    render :index
  end

  def jobs
    if current_admin
      # admin sees all jobs
      @jobs = JobLog.includes(:user).order(created_at: :desc).limit(10)
    elsif current_user
      # normal user sees only their jobs
      @jobs = JobLog.includes(:user)
                    .where(user_id: current_user.id)
                    .order(created_at: :desc)
                    .limit(10)
    else
      @jobs = []
    end

    render json: @jobs.as_json(
      only: [:id, :message, :status, :created_at],
      include: { user: { only: [:name, :email, :department] } }
    )
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :dob, :department, :email)
  end
end

