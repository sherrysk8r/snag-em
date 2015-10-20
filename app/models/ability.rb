class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user, or not yet logged in

    if user.role? :admin # not really applicable right now, but hey
        can :manage, :all
    elsif user.role? :user
        can :update, User, :id => user.id
        can :update, Post, :owner_id => user.id
        can :update, Tagalong, :id => user.id
        can :read, Post
        can :create, Post
        can :read, User
    else
        can :update, User, :id => user.id
    end

  end


end
