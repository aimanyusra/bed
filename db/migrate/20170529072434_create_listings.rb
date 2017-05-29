class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :address
      t.string :price
      t.string :type
      t.integer :guests
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
