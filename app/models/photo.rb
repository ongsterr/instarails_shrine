class Photo < ApplicationRecord
  include ImageUploader::Attachment.new(:image) # adds an `image` virtual attribute
  belongs_to :user
  has_and_belongs_to_many :likers, class_name: 'User', join_table: :likes # Check the has_and_belongs_to_many method

  def liked_by?(user)
    # likers - relationship has_and_belongs_to_many
    # exists? checks if there is a record with user
    # id of the user we need to check
    likers.exists?(user.id)
  end

  def toggle_liked_by(user)
    if liked_by?(user)
      likers.destroy(user)
    else
      likers << user
    end
  end

end
