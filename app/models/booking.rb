class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validate :check_overlapping_dates
  validate :check_max_guests

  def check_overlapping_dates
  	errors.add(:overlapping_dates, "The booking dates conflict with existing bookings")
  end

  def check_max_guests

  end

  
end
