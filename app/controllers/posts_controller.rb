class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :read, Post
  	@posts = Post.not_mine(current_user.id).chronological
    @my_posts = Post.for_owner(current_user.id).chronological
  end

  def filter_by_workout
    @filtered_by_workout = Post.filter_by_workout(params[:workout_search])
  end

  def filter_by_time
    #@filtered_by_date = Post.filter_by_date(params[:date_search])
    #@filtered_by_time = Post.filter_by_time(params[:date_search], params[:time_search_start], params[:time_search_stop])
    #@filtered_by_date_and_time = Post.filter_by_date_and_time(params[:date_search], params[:time_search])
    @filtered_by_datetime = Post.filter_by_datetime(params[:datetime_search])
  end

  def find_a_workout
  end

  def show
    authorize! :read, @post
    @post = Post.find(params[:id])
    authorize! :read, @post
  end

  def new
    authorize! :create, Post
    @post = Post.new
  end

  def edit
  end

  def create
    authorize! :create, Post
    params[:post][:owner_id] = current_user.id
    params[:post][:start] = Chronic.parse(post_params[:start])
  	
    @post = Post.new(post_params)
  	
    if @post.save
      redirect_to posts_url, notice: 'Event was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Congrats! You\'ve succesfully updated your event.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  # A simple form that is submitted through AJAX. Found on post show
  def addtagalong
    @tagalong = Tagalong.new(tagalong_params)
    @post = Post.find(@tagalong.post_id)
    if @tagalong.valid?
      @tagalong.save
      redirect_to posts_url, notice: 'You successfully requested to tagalong.'
    else
      format.json { render json: @tagalong.errors, status: :unprocessable_entity }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:owner_id, :title, :topic, :start, :expected_duration_hr, :expected_duration_min, :details, :cancelled, :estimated_difficulty)
    end

    def tagalong_params
      params.require(:tagalong).permit(:user_id, :post_id, :showed_up)
    end
end
