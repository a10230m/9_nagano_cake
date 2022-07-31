class Admin::OrderDetailsController < ApplicationController










  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :purchase_price, :amount, :production_status)
  end

end

