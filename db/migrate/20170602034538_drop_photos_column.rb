class DropPhotosColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :listings, :photos
  end
end
