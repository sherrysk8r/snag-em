class Tagalong < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	has_one :review

	scope :for_user,   ->(user_id) { where(user_id: user_id) }
	# scope :upcoming, -> { joins(:post).where('upcoming') }
	# scope :past, -> { joins(:post).where('past') }
	scope :approved_tagalongs, -> { where(approved: true)}

	validates_uniqueness_of :user_id, :scope => :post_id

	def self.upcoming
		self.joins(:post).where("date > ?", Date.today).where("start_time > ?", Time.now).where("approved == ?", true)
	end

	def self.past
		self.joins(:post).where("date <= ?", Date.today).where("start_time <= ?", Time.now).where("showed_up == ?", true)
	end

	def mark_as_showed_up
		self.showed_up = true
		self.save!
	end

end
