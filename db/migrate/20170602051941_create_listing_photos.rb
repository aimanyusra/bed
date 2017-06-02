class CreateListingPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :listing_photos do |t|
      t.integer :listing_id
      t.string :image

      t.timestamps
    end
  end
end
