class GroupsController < ApplicationController
	before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
  	@groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to groups_url, notice: 'Event was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Congrats! You\'ve succesfully updated your group.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def post_params
      params.require(:group).permit(:private, :domain, :company)
end
