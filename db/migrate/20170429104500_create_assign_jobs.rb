class CreateAssignJobs < ActiveRecord::Migration
  def change
    create_table :assign_jobs do |t|
      t.integer :job_id
      t.string :user_ids
      t.timestamps null: false
    end
  end
end
