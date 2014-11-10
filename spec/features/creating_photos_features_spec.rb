require 'rails_helper'

describe 'creating a photo' do

	it 'creates a photo' do
		@photo = Photo.create(title: 'title for photo', description: 'description for photo')
		visit '/photos'
		expect(page).to have_content 'title for photo'
		expect(page).not_to have_content 'No photos yet'
	end

	context 'with user loggin' do

		before do
			@user = User.create(email: "ana@test.com", password:"12345678", password_confirmation:"12345678")
			login_as @user
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
end