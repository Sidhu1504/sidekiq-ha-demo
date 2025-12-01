class UserMailer < ApplicationMailer
  default from: "3sinnovators@gmail.com"

  def job_done_email(user)
    @user = user
    mail(to: @user.email, subject: "Your Background Job Is Done")
  end
end

