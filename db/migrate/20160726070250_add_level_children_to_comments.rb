class AddLevelChildrenToComments < ActiveRecord::Migration
  def change
    add_column :comments, :level, :integer, :default => 0
    add_column :comments, :children_count, :integer, :default => 0
  end
end
