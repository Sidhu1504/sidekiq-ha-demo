class UserMailer < ApplicationMailer
  default from: "3sinnovators@gmail.com"

  def job_done_email(user)
    return if user.email.blank?   # ✅ SAFETY GUARD

    @user = user
    mail(to: @user.email, subject: "Your Background Job Is Done")
  end
end

