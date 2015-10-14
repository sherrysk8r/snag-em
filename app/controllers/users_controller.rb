class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @user_upcoming_posts = Post.for_owner(@user.id).upcoming
    @user_past_posts = Post.for_owner(@user.id).past
    @user_upcoming_tagalongs = Tagalong.for_user(@user.id).upcoming
    @user_past_tagalongs = Tagalong.for_user(@user.id).past
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  def pending_tagalongs
    @pending_tagalongs = current_user.pending_tagalongs
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :city, :state, :about_me, :date_of_birth, :password, :password_confirmation, :active)
    end
end
