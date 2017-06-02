class ImagesController < ApplicationController
  before_action :set_listing

  def create
    byebug
    add_more_images(images_params)
    flash[:error] = "Failed uploading images" unless @listing.save
    redirect_to :back
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @listing.save
    redirect_to :back
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def add_more_images(new_images)
    images = @listing.images 
    images += new_images
    @listing.images = images
  end

  def remove_image_at_index(index)
    remain_images = @listing.images # copy the array
    deleted_image = remain_images.delete_at(index) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    @listing.images = remain_images # re-assign back
  end

  def images_params
    params.require(:listing).permit({images: []}) # allow nested params as array
  end
end