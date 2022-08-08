class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end


  def confirm
		@order = Order.new
		@cart_items = current_customer.cart_items
		@order.payment_method = params[:order][:payment_method]
	    if params[:order][:address_option] == "0"
			  @order.postal_code = current_customer.postal_code
		  	@order.address = current_customer.address
		  	@order.name = current_customer.last_name + current_customer.first_name
		  else params[:order][:address_option] == "2"
			  @order.postal_code = params[:order][:postal_code]
			  @order.address = params[:order][:address]
			  @order.name = params[:order][:name]
			end
	end


  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_details = OrderDetail.new(order_detail_params)
        @order_details.item_id = cart_item.item.id
        @order_details.purchase_price = cart_item.item.price
        @order_details.amount = cart_item.amount
        @order_details.order_id = @order.id
        @order_details.save
      end
      current_customer.cart_items.destroy_all
      redirect_to complete_path
  end


  def complete
  end


  def index
    @customer = current_customer
    @orders = current_customer.orders.includes(:order_details, :items)
  end


  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_details
  end


private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :amount_billed, :purchase_price, :customer_id)
  end

  def order_detail_params
    params.permit(:item_id, :purchase_price, :amount, :order_id)
  end


end
