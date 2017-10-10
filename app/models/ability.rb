class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_a? Admin
      can :manage, :all
    elsif user.is_a?(User) && user.persisted?
      can :read, [Author, Book, Category, Coupon, Delivery]
      can %i[read create], Review
      can %i[read create update], [Order, Address, CreditCard], user_id: user.id
      can :manage, OrderItem
      can :manage, User, id: user.id
    else
      can :read, [Author, Book, Category, Review]
      can :manage, OrderItem
    end
  end
end
