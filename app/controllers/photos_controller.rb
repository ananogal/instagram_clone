class PhotosController < ApplicationController

	def index
		@photos = Photo.all
	end

	def new 
		@photo = Photo.new
	end

	def create
		@photo = Photo.create(params[:photo].permit(:title, :description))
		redirect_to '/photos'
	end

end
