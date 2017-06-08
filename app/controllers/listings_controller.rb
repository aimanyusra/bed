class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  
  def search
    options = {
      fields: %w(name location),
      misspellings: { below: 5 },
      page: params[:page], 
      per_page: 10
    }

    options[:where] = { verified: 'verified' } if current_user.moderator? || current_user.superadmin?

    @listings = Listing.search(params[:autocomplete], options)
    if @listings.blank?
      redirect_to listings_path, flash:{danger: "no successful search result"}
    else
      render :index
    end
  end

  def verify
    @listings = Listing.find(params[:listing_id])
    @listings.verified!
    redirect_to :back
  end  
  
  def unverify
    @listings = Listing.find(params[:listing_id])
    @listings.unverified!
    redirect_to :back
  end
  
  # GET /listings
  # GET /listings.json
  def index
    # @listings = Listing.all
    @listings = Listing.order(:name).page params[:page]
  end

  # GET /listings/1
  # GET /listings/1.json
  def show

    @booking = @listing.bookings.new

    @listing = Listing.find(params[:id])
    @listing_photos = @listing.listing_photos.all

  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @listing_photo = @listing.listing_photos.build
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = current_user.listings.new(listing_params)

    respond_to do |format|
      if @listing.save
        params[:listing_photos]['image'].each do |a|
        @listing_photo = @listing.listing_photos.create!(:image => a, :listing_id => @listing.id)
        end
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
    store_photos
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:description, :address, :num_of_bedrooms, :num_of_guests, :name, :location, listing_photos_attributes: [:id, :listing_id, :image])
    end

    def store_photos
        photos = params[:listing][:images]
        photos.each{|photo| @listing.listing_photos.create(image: photo)} if photos
    end

end
