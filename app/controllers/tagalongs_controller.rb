class TagalongsController < ApplicationController
	def index
		@tagalong = Tagalong.all
	end

	def show
	end

	def new
		@tagalong = Tagalong.new
	end

	def edit
	end

    def create
		@tagalong = Tagalong.new
		if @tagalong.save
	      redirect_to posts_url, notice: 'Tagalong was successfully added.'
	    else
	      render action: 'new'
	    end
    end

    def destroy
    	@tagalong.destroy
    	redirect_to posts_url
    end

	private
	def tagalong_params
      params.require(:tagalong).permit(:user_id, :post_id, :showed_up)
    end
end
