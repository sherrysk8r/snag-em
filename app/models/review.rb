class Review < ActiveRecord::Base
	belongs_to :tagalong

	validates_numericality_of :owner_stars, only_integer: true, inclusion: {1..5}
	validates_numericality_of :accuracy_of_event_stars, only_integer: true, inclusion: {1..5}
end
