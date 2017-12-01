class AddJobTitleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_title, :string
    add_column :users, :company_name, :string
  end
end
