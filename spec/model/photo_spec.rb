require 'rails_helper'

RSpec.describe Photo do
	it 'should have a title of at least 3 characters' do
		photo = Photo.new(title: 'ti')
		expect(photo).to have(1).error_on(:title)
		expect(photo).not_to be_valid
	end
end