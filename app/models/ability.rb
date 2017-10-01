class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.persisted?
      can :read, [Author, Book, Category, Coupon, Delivery, Image]
      can :read, Review
      can :create, Review
      can %i[read create update], [Order, Address, CreditCard], user_id: user.id
      can :manage, OrderItem
      can :manage, User, id: user.id
    else
      can :read, Review
      can :read, [Author, Book, Category, Image]
      can :manage, OrderItem
    end
  end
end
