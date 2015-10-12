class Post < ActiveRecord::Base
	has_many :tagalongs
	belongs_to :user

	validates_numericality_of :estimated_difficulty, only_integer: true
	validates_inclusion_of :estimated_difficulty, :in=>1..10, :message =>"must be between 1 and 10"


	scope :for_owner,   ->(user_id) { where(owner_id: user_id) }

	# adjust this scope so that also start_time >= Time.now
	scope :upcoming, -> { where('start_date >= ?', Date.today) }
	scope :for_difficulty, ->(difficulty) { where(estimated_difficulty: difficulty) }
	scope :cancelled, ->{ where(cancelled: true)}
	scope :not_cancelled, ->{ where(cancelled: false)}
end
