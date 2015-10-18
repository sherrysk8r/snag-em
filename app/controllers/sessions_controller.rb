class SessionsController < ApplicationController
	def new
    end

    def create
      user = User.find_by_email(params[:email])
      if user && User.authenticate(params[:email], params[:password])
        session[:user_id] = user.id
        # may want to redesign this as a notification
        # if user.pending_tagalongs.length != 0
        #   redirect_to pending_url, notice: "Logged in!"
        # else
          redirect_to posts_url, notice: "Logged in!"
        # end
      else
        flash.now.alert = "Email or password is invalid"
        render "new"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to home_path, notice: "Logged out!"
    end
end
