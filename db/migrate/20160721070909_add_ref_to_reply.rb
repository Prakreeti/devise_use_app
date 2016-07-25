class AddRefToReply < ActiveRecord::Migration
  def change
    add_reference :replies, :user, index: true, foreign_key: true
    add_reference :replies, :comment, index: true, foreign_key: true
    add_reference :replies, :post, index: true, foreign_key: true
  end
end
