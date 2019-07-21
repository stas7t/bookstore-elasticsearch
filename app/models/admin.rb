# frozen_string_literal: true

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :skip_password_validation

  validates :email,
            presence: true,
            format: { with: /@/,
                      message: 'ivalid format' }

  validates :password,
            format: { with: /\A\S(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\S*\z/i,
                      message: 'should contain at least 1 uppercase, at least \
                      1 lowercase, at least 1 number and no whitespeses.' },
            unless: :skip_password_validation
end
