class Post < ActiveRecord::Base
	require 'date'
	require 'time'

	has_many :tagalongs
	belongs_to :user, foreign_key: "owner_id"

	validates_numericality_of :estimated_difficulty, only_integer: true
	validates_inclusion_of :estimated_difficulty, in: 1..10, message: "must be between 1 and 10"

	validates_date :date, on_or_after: lambda { Date.today }, on_or_after_message: "cannot be in the past", on:  :create
	
	validates_numericality_of :expected_duration_min, only_integer: true
	validates_inclusion_of :estimated_difficulty, in: 0..60, message: "must be between 0 and 60"

	validates_numericality_of :expected_duration_hr, only_integer: true
	validates_inclusion_of :expected_duration_hr, in: 0..5, message: "Your event is over 5 hours long?"

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
		self.date.strftime('%m/%d/%Y') + " (" + self.start_time.strftime('%H:%M %p') + ")"
	end

    def self.filter_by_workout(workout_search)
      if workout_search
        self.where("topic LIKE ?", workout_search)
      else
          []
      end
    end

    def self.filter_by_date_and_time(date_search, time_search)
	if date_search && time_search
		start = Time.parse(time_search.first)
		self.where("date = ? AND start_time >= ?", date_search, start)
	else
		[]
	end
    end

    # def self.filter_by_time(date_search, time_search_start, time_search_stop)
    # 	if date_search && time_search_start && time_search_stop
    # 		start = Time.parse(time_search_start.first)
    # 		stop = Time.parse(time_search_stop.first)
    # 		self.where("date = ? AND start_time >= ? AND start_time <= ?", date_search, start, stop)
    #     else
    #         []
    #     end
    # end


    # def self.filter_by_date(date_search)
    #     if date_search
    #         self.where("date = ?", date_search)
    #     else
    #         []
    #     end
    # end
end
