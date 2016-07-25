class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :reply_to, :integer
    add_column :comments, :base_reply, :integer
  end
end
