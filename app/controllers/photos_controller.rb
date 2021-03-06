class PhotosController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]
	
	def index
		@photos = Photo.all
	end

	def new 
		@photo = Photo.new
	end

	def create
		@photo = Photo.create(params[:photo].permit(:title, :description, :image))
		if @photo.save
			redirect_to '/photos'
		else
			render 'new'
		end
	end

	def edit
		@photo = Photo.find(params[:id])
	end

	def update
		@photo = Photo.find(params[:id])
		@photo.update(params[:photo].permit(:title, :description))
		redirect_to '/photos'
	end

	def destroy
		@photo = Photo.find(params[:id])
		@photo.destroy
		flash[:notice] = 'Photo deleted successfully'
		redirect_to '/photos'
	end

	def show
		@photo = Photo.find(params[:id])
	end

end
