class User < ActiveRecord::Base
	mount_uploader :photo, PhotoUploader

	has_many :posts, foreign_key: "owner_id"
	has_many :tagalongs

	has_secure_password

	scope :alphabetical, -> { order("last_name, first_name") }

	# active refers to whether someone's account is active
  	scope :active,       -> { where('active = ?', true) }

  	validates_presence_of :first_name, :last_name, :email  
	validates_uniqueness_of :email, :allow_blank => true
	validates_format_of :email, :with => /\A[\w]([^@\s,;]+)@(([a-z0-9.-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, :message => "is not a valid format", :allow_blank => true
	validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
	validates_presence_of :password, :on => :create 
	validates_presence_of :password_confirmation, :on => :create 
	validates_confirmation_of :password, :message => "does not match"
	validates_length_of :password, :minimum => 4, :message => "must be at least 4 characters long", :allow_blank => true

	before_save :reformat_phone

	ROLES = [['Administrator', :admin],['User', :user]]

	def role?(authorized_role)
		return false if role.nil?
		role.to_sym == authorized_role
	end

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
		return self.posts.map{|p| p.tagalongs.where("approved IS NULL")}.flatten.to_a
	end

	def reformat_phone
	    self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
    end

end
