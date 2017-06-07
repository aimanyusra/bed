class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(customer, host, listing_id, booking_id)
     ReservationMailer.notification_email(customer, host, listing_id, booking_id).deliver_now
  end
end

