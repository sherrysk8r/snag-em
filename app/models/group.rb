class Group < ActiveRecord::Base
	before_save :find_pic

	def find_pic
		# can change the size of the image by adding .com?size = xx
		# thanks to https://blog.clearbit.com/logo
		if this.company
			this.picture = "https://logo.clearbit.com/" + this.name.downcase.gsub(/\s+/, "") + ".com"
		end
	end
end
