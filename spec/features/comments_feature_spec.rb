require 'rails_helper'

describe 'commenting' do
	it 'allows users to leave a comment thought a form' do
		@photo = Photo.create(title: 'title for photo', description: 'description for photo')
		visit '/photos'
		click_link 'Comment'
		fill_in 'Thoughts', with: "Cool!"
		click_button 'Leave Comment'
		expect(current_path).to eq '/photos'
		expect(page).to have_content 'Cool!'
	end
end