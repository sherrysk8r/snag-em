class Post < ActiveRecord::Base
	has_many :tagalongs
	belongs_to :user, foreign_key: "owner_id"

	validates_numericality_of :estimated_difficulty, only_integer: true
	validates_inclusion_of :estimated_difficulty, in: 1..10, message: "must be between 1 and 10"

	validates_date :date, on_or_after: lambda { Date.today }, on_or_after_message: "cannot be in the past", on:  :create

	scope :for_owner,   ->(user_id) { where(owner_id: user_id) }
	scope :not_mine, -> (user_id) {where("owner_id != ? ", user_id)}

	scope :for_difficulty, ->(difficulty) { where(estimated_difficulty: difficulty) }
	scope :cancelled, ->{ where(cancelled: true)}
	scope :not_cancelled, ->{ where(cancelled: false)}
	scope :chronological, -> {order('date','start_time')}

	def self.upcoming
		self.where("date > ?", Date.today).where("start_time > ?", Time.now)
	end

	def self.past
		self.where("date <= ?", Date.today).where("start_time <= ?", Time.now)
	end

	def datetime
		self.date.strftime('%m/%d/%Y') + " " + self.start_time.strftime('%H:%M %p')
	end
end
