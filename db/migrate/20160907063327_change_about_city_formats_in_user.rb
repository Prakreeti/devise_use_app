class ChangeAboutCityFormatsInUser < ActiveRecord::Migration
  def change
  	change_column :users, :city, :longtext
  	change_column :users, :about, :longtext
  end
end
