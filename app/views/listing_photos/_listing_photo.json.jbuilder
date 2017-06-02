json.extract! listing_photo, :id, :listing_id, :image, :created_at, :updated_at
json.url listing_photo_url(listing_photo, format: :json)
