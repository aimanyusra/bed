class Listing < ApplicationRecord

	has_many :listing_photos

	belongs_to :user

	paginates_per 10

	enum verified: [:unverified, :verified]
end
