class AddLocationColumnToListings < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :location, :string
  end
end
