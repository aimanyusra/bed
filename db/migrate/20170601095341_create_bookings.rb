class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :listing, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
