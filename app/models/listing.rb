class Listing < ApplicationRecord

	mount_uploaders :images, PhotosUploader
	serialize :images, Array
	belongs_to :user

	paginates_per 10

	enum verified: [:unverified, :verified]
end
