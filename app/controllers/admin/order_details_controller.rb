class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  # def show
  #   @order = Order.find(params[:id])
  # end

  # def update
  #   @order_detail = OrderDetail.find(params[:id])
  #   @order_detail.update(order_detail_params)
  #   flash[:success] = "更新に成功しました"
  # 	redirect_to admin_order_path(@order_detail.order)
  # end


  def update
		@order_detail = OrderDetail.find(params[:id])
		@order_detail.update(order_detail_params)

      if @order_detail.production_status == "in_production"
        @order_detail.order.update(order_status: 2)
      elsif @order_detail.order.order_details.count == @order_detail.order.order_details.where(production_status: "production_complete").count
        @order_detail.order.update(order_status: 3)
      end
		redirect_to admin_order_path(@order_detail.order) #注文詳細に遷移
	end


  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
