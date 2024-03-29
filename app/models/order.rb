class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_details, dependent: :destroy

	has_many :items, through: :order_details
# 	accepts_nested_attributes_for :ordered_items





  def subtotal
    item.with_tax_price * amount
  end

  enum payment_method: {
    credit_card: 0,
    transfer: 1
  }

  enum order_status: {
    payment_waiting: 0,
    payment_confirmation: 1,
    in_production: 2,
    preparing_delivery: 3,
    delivered: 4
  }
end
