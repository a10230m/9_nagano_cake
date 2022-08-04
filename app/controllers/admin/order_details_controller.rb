class Admin::OrderDetailsController < ApplicationController


  # def show
  #   @order = Order.find(params[:id])
  # end

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    flash[:success] = "更新に成功しました"
  	redirect_to admin_order_path(@order_detail.order)
  end


  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
