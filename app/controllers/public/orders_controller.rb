class Public::OrdersController < ApplicationController



  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end


  def confirm
  @order = Order.new(order_params)
  @order.postal_code = current_customer.postal_code
  @order.address = current_customer.address
  @order.name = current_customer.last_name + current_customer.first_name
  @cart_items = current_customer.cart_items.all
  end


  def create
    order = Order.new(order_params)
    order.save
    @order_details = OrderDetail.new
    @order_details.order_id = current_customer.order_ids
    #現在、ログインしているユーザーのcart_itemを取ってくる。
    @cart_items = current_customer.cart_items.all
    #次に、each文で分解 (eachを使うことで、1個1個処理できる。)
    @cart_items.each do |cart_item|
      @order_details.item_id = cart_item.item.id
      @order_details.purchase_price = cart_item.item.price
      @order_details.amount = cart_item.amount
      @order_details.save
    end
    #カート内の商品を全て削除
    current_customer.cart_items.destroy_all
    redirect_to complete_path
  end




  def complete
  end


  def index
    @orders = current_customer.orders
  end


  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end


private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :amount_billed, :purchase_price)
  end




end
