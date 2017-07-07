class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :users, :varify_candidate, :verify_candidate
  end
end
