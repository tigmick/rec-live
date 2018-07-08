class AddFieldsToUserJobs < ActiveRecord::Migration
  def change
    add_column :user_jobs, :candidate_id, :integer
    add_column :user_jobs, :job_id, :integer
    add_column :user_jobs, :accepted, :boolean
    add_column :user_jobs, :rejected, :boolean
    add_column :user_jobs, :accepted_at, :date
    add_column :user_jobs, :rejected_at, :date
  end
end
