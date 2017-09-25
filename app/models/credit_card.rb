class CreditCard < ApplicationRecord
  belongs_to :order, optional: true
end
