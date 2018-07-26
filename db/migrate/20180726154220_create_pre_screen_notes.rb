class CreatePreScreenNotes < ActiveRecord::Migration
  def change
    create_table :pre_screen_notes do |t|
      t.text :note
      t.integer :interview_id

      t.timestamps null: false
    end
  end
end
