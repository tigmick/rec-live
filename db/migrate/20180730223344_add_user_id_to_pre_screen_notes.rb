class AddUserIdToPreScreenNotes < ActiveRecord::Migration
  def change
    add_column :pre_screen_notes, :user_id, :integer
  end
end
