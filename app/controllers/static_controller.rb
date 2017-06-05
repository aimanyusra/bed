class StaticController < ApplicationController
	def index
		@listing = Listing.where(verified:"verified")
		render 'static/index'
	end
end
