class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
  	@posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
  	@post = Post.new(post_params)
  	params[:post][:owner_id] = current_user.id
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
      redirect_to posts_url, notice: 'Tagalong was successfully added.'
    else
      format.json { render json: @tagalong.errors, status: :unprocessable_entity }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:owner_id, :title, :topic, :date, :start_time, :expected_duration, :details, :cancelled, :estimated_difficulty)
    end

    def tagalong_params
      params.require(:tagalong).permit(:user_id, :post_id, :showed_up)
    end
end
