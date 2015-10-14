class ReviewsController < ApplicationController

def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to user_path(current_user)
end

end
