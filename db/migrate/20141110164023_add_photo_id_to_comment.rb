class AddPhotoIdToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :photo, index: true
  end
end
