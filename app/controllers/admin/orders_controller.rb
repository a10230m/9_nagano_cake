class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_details
  end

  def update
  	@order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
    flash[:success] = "更新に成功しました"
  	redirect_to admin_order_path
  end



private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :amount_billed, :purchase_price, :customer_id, :order_status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :purchase_price, :amount, :order_id, :production_status)
  end
end