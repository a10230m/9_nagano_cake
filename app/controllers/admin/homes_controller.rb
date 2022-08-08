class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    # @orders = customer.orders.includes(:order_details)
    @orders = Order.page(params[:page])
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage,
    :amount_billed, :purchase_price, :customer_id)
  end

  def order_detail_params
  params.permit(:item_id, :purchase_price, :amount, :order_id)
  end


end
