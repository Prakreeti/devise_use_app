class ChangeTitleFormatInPosts < ActiveRecord::Migration
  def change
  	change_column :posts, :title, :longtext
  end
end
