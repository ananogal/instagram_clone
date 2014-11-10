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
	end
end