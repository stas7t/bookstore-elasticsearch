class BillingAddress < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :user
end
