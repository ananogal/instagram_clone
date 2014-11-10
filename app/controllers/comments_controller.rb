class CommentsController < ApplicationController

	def new
		@photo = Photo.find(params[:photo_id])
		@comment = Comment.new
	end

	def create 
		@photo = Photo.find(params[:photo_id])
		@photo.comments.create(params[:comment].permit(:thoughts))
		redirect_to '/photos'
	end
end
