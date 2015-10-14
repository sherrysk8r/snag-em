class Review < ActiveRecord::Base
	belongs_to :tagalong

	validates_numericality_of :owner_stars, only_integer: true
	validates_inclusion_of :owner_stars, :in=>1..5, :message =>"must be between 1 and 5"
	validates_numericality_of :accuracy_of_event_stars, only_integer: true
	validates_inclusion_of :accuracy_of_event_stars, :in=>1..5, :message =>"must be between 1 and 5"
end
