class AddDetailsToJobLogs < ActiveRecord::Migration[8.0]
  def change
    add_reference :job_logs, :user, null: true, foreign_key: true
    add_column :job_logs, :status, :string
  end
end

