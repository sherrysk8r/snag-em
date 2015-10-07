class Post < ActiveRecord::Base
	has_many :tagalongs
	belongs_to :user

	scope :for_owner,   ->(user_id) { where(owner_id: user_id) }
end
