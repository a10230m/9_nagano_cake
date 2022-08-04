class OrderDetail < ApplicationRecord

  belongs_to :item
  belongs_to :order

  def subtotal
    item.with_tax_price * amount
  end


  def with_tax_price
    (price * 1.1).floor
  end

  enum production_status: {
    production_not_possible: 0,
    production_pending: 1,
    in_production: 2,
    production_complete: 3
  }


end