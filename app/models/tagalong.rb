class Tagalong < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	has_one :review

	scope :for_user,   ->(user_id) { where(user_id: user_id) }

	validates_uniqueness_of :user_id, :scope => :post_id
end
