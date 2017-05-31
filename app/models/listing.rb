class Listing < ApplicationRecord

	mount_uploaders :photos, PhotoUploader
	serialize :photos, Array
	belongs_to :user

	paginates_per 10

	enum verified: [:unverified, :verified]
end
