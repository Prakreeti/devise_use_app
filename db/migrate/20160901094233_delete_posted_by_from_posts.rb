class DeletePostedByFromPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :posted_by, :string
  end
end
