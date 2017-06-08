class Listing < ApplicationRecord

  	belongs_to :user
  	has_many :bookings
	has_many :listing_photos

	belongs_to :user

	paginates_per 10

	enum verified: [:unverified, :verified]

	searchkick match: :word_start, searchable: [:name, :location]
end
