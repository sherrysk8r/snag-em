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
		if !params[:status].nil? && params[:status] == "approved"
    		
			tagalong = Tagalong.find(params[:id])
			tagalong.approved = true
			tagalong.save!
			flash[:notice] = "#{tagalong.user.proper_name} was approved to join you on #{tagalong.post.date.strftime('%m/%D/%Y')} on #{tagalong.post.start_time.strftime('%h:%M %p')}"
			
			redirect_to pending_url
		end

	end

    def create
		@tagalong = Tagalong.new
		if @tagalong.save
	      redirect_to posts_path, notice: 'Tagalong was successfully added.'
	    else
	      render action: 'new'
	    end
    end

    def update
    	@tagalong = Tagalong.find params[:id]
	    if @tagalong.update(tagalong_params)
	    	#we aren't going to redirect to tagalong, want to stay on post page
	    	redirect_to posts_path, notice: 'Congrats! You\'ve succesfully updated your tagalongs.'
	    else
	    	render action: 'edit'
	    end
	end

    def destroy
    	@tagalong.destroy
    	redirect_to posts_url
    end

	# A simple form that is submitted through AJAX. Found on user page
	def addreview
		@review = Review.new(review_params)
		@tagalong = Tagalong.find(@review.tagalong_id)
		if @review.valid?
		  @review.save
		  redirect_to user_url(current_user), notice: 'Review was successfully added.'
		else
		  format.json { render json: @review.errors, status: :unprocessable_entity }
		end
	end

	private
	def tagalong_params
      params.require(:tagalong).permit(:user_id, :post_id, :showed_up)
    end

    def review_params
      params.require(:review).permit(:tagalong_id, :owner_stars, :accuracy_of_event_stars, :review)
    end
end
