class AddClientCommentToJob < ActiveRecord::Migration
  def change
  	add_column :jobs, :client_comment, :text
  end
end
