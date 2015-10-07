class Tagalong < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	has_one :review
end
