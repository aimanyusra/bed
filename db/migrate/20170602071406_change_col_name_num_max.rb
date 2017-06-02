class ChangeColNameNumMax < ActiveRecord::Migration[5.0]
  def change
  	remove_column :listings, :num_of_guests
  	add_column :listings, :max_guests, :integer
  end
end
