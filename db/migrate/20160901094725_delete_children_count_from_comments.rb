class DeleteChildrenCountFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :children_count, :integer
  end
end
