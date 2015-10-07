class Post < ActiveRecord::Base
	has_many :tagalongs
	belongs_to :user
end
