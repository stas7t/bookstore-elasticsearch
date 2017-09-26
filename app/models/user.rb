class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]

  validates :password,
            format: { with: /\A\S(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\S*\z/i,
                      message: 'should contain at least 1 uppercase, at least 1 lowercase, at least 1 number and no whitespeses.' }

  has_many :orders
  has_many :reviews
  has_many :addresses

  has_one :billing
  has_one :shipping
  has_one :credit_card

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar = auth.info.image
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
