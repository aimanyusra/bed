class AddPriceToListing < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :price, :integer
  	remove_column :listings, :images
  end
end
