require 'rails_helper'

describe 'photos' do

	it 'should have no photos' do
		visit '/photos'
		expect(page).to have_content 'No photos yet'
		expect(page).to have_link 'Add a photo' 
	end

	context 'managing a photo' do
		before do
			@user = User.create(email: "ana@test.com", password:"12345678", password_confirmation:"12345678")
			login_as @user
			@photo = @user.photos.create(title: 'Title for photo', description: 'description for photo')
		end

		context 'when editing' do
			it 'should let a user to edit a photo' do
				visit '/photos'
				click_link 'Edit Photo'
				fill_in 'Title', with: 'Hello'
				fill_in 'Description', with: 'another description'
				click_button 'Update Photo'
				expect(page).to have_content 'Hello'
				expect(current_path).to eq '/photos'
			end	

			it 'should not let another user to edit the photo' do
				@user2 = User.create(email: "user@test.com", password:"12345678", password_confirmation:"12345678")
				login_as @user2
				visit '/photos'
				expect(page).not_to have_link 'Edit Photo'
			end
		end

		context 'when deleting' do
			it 'should let a user to delete a photo' do
				visit '/photos'
				click_link 'Delete Photo'
				expect(page).to have_content 'Photo deleted successfully'
				expect(current_path).to eq '/photos'
			end

			it 'should not let another user to delete the photo' do
				@user2 = User.create(email: "user@test.com", password:"12345678", password_confirmation:"12345678")
				login_as @user2
				visit '/photos'
				expect(page).not_to have_link 'Delete Photo'
			end
		end

		context 'when viewing a photo' do
			before do
				@photo.comments.create(thoughts: 'Comment 1')
			end

			it 'should show all its comments' do
				visit '/photos'
				click_link 'Title for photo'
				expect(page).to have_content 'Comment 1'
			end
		end
	end
end