require 'rails_helper'

describe 'photos' do

	it 'should have no photos' do
		visit '/photos'
		expect(page).to have_content 'No photos yet'
		expect(page).to have_link 'Add a photo' 
	end

	context 'creating a photo' do

		it 'creates a photo' do
			@photo = Photo.create(title: 'title for photo', description: 'description for photo')
			visit '/photos'
			expect(page).to have_content 'title for photo'
			expect(page).not_to have_content 'No photos yet'
		end

		it 'should create a photo from a form' do
			visit '/photos'
			click_link 'Add a photo'
			fill_in 'Title', with: 'A photo'
			fill_in 'Description', with: "description for photo"
			click_button 'Create Photo'
			expect(page).to have_content 'A photo'
			expect(current_path).to eq '/photos'
		end

		it 'should upload an image to photo' do
			visit '/photos/new'
			attach_file "Image", 'public/images/thumb/missing.png'
			click_button 'Create Photo'
		end 

		it 'should give a title with 3 charaters' do
			visit '/photos'
			click_link 'Add a photo'
			fill_in 'Title', with: 'hi'
			fill_in 'Description', with: "description for photo"
			click_button 'Create Photo'
 			expect(page).to have_content 'error'
		end

	end

	context 'editing a photo' do
		it 'should let a user to edit a photo' do
			@photo = Photo.create(title: 'title for photo', description: 'description for photo')
			visit '/photos'
			click_link 'Edit Photo'
			fill_in 'Title', with: 'Hello'
			fill_in 'Description', with: 'another description'
			click_button 'Update Photo'
			expect(page).to have_content 'Hello'
			expect(current_path).to eq '/photos'
		end	
	end

	context 'deleting photo' do
		it 'should let a user to delete a photo' do
			@photo = Photo.create(title: 'title for photo', description: 'description for photo')
			visit '/photos'
			click_link 'Delete Photo'
			expect(page).to have_content 'Photo deleted successfully'
			expect(current_path).to eq '/photos'
		end
	end
end