class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    can :manage, :all if user.role == 'admin'

    return unless user.role == 'user'

    can :destroy, Post, author_id: user.id
    can :destroy, Comment, author_id: user.id
  end
end
