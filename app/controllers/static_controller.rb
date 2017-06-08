class StaticController < ApplicationController
	def index
		@user = current_user
		@listing = Listing.where(verified:"verified")
		render 'static/index'
	end
end
