class ListingsController < ApplicationController
  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      sign_in @user
      redirect_back_or url_after_create
      
    else
      # render template: "users/new"
      respond_to do |format|
        format.html { render template: "users/new" }
        format.js
      end
    end
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
