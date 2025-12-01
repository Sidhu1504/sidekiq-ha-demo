module Admin
  class DashboardController < ApplicationController
    before_action :require_admin

    def index
      @users_count    = User.count
      @jobs_count     = JobLog.count
      @recent_users   = User.order(created_at: :desc).limit(5)
      @recent_jobs    = JobLog.includes(:user).order(created_at: :desc).limit(10)
    end
  end
end

