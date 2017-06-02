class AddMaxGuestsToBooking < ActiveRecord::Migration[5.0]
  def change
  	add_column :bookings, :num_of_guests, :integer
  end
end
