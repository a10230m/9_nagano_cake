class Admin::OrderDetailsController < ApplicationController


  def show
    @order = Order.find(params[:id])
  end

  # 上のエラー解消させる







  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :purchase_price, :production_status, :amount)
  end
end
