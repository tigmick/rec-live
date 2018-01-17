class AddClosedAtToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :closed_at, :datetime
  end
end
