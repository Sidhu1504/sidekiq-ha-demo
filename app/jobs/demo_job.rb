# app/jobs/demo_job.rb
class DemoJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    log = JobLog.create!(
      user: user,
      message: "Job started for #{user.name}",
      status: "running"
    )

    sleep 3

    log.update!(
      message: "Job finished for #{user.name}",
      status: "done"
    )

    UserMailer.job_done_email(user).deliver_now
  rescue => e
    JobLog.create!(
      user: user,
      message: "Job failed for #{user.name}: #{e.message}",
      status: "failed"
    )
    raise
  end
end

