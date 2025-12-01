class CreateJobLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :job_logs do |t|
      t.string :message

      t.timestamps
    end
  end
end
