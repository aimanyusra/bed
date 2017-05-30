class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.references :user, foreign_key: true
      t.string :description
      t.string :address
      t.string :num_of_bedrooms
      t.integer :num_of_guests
      t.string :name

      t.timestamps
    end
  end
end
