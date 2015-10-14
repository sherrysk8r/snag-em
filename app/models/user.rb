class User < ActiveRecord::Base
	has_many :posts, foreign_key: "owner_id"
	has_many :tagalongs

	has_secure_password

	scope :alphabetical, -> { order("last_name, first_name") }

	# active refers to whether someone's account is active
  	scope :active,       -> { where('active = ?', true) }

  	validates_presence_of :first_name, :last_name, :email  
	validates_uniqueness_of :email, :allow_blank => true
	validates_format_of :email, :with => /\A[\w]([^@\s,;]+)@(([a-z0-9.-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, :message => "is not a valid format", :allow_blank => true
	validates_presence_of :password, :on => :create 
	validates_presence_of :password_confirmation, :on => :create 
	validates_confirmation_of :password, :message => "does not match"
	validates_length_of :password, :minimum => 4, :message => "must be at least 4 characters long", :allow_blank => true
	
	def proper_name
      first_name + " " + last_name
    end
	  
	def name
	  last_name + ", " + first_name
	end

	def self.authenticate(email, password)
	  find_by_email(email).try(:authenticate, password)
	end

	def perc_cancelled
		return self.posts.cancelled.length/self.posts.length
	end

	def pending_tagalongs
		return self.posts.map{|p| p.tagalongs.where("approved IS NULL")}.compact
	end
end
