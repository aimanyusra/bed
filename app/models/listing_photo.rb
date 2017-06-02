class ListingPhoto < ApplicationRecord
	mount_uploader :image, PhotosUploader

	belongs_to :listing
end
