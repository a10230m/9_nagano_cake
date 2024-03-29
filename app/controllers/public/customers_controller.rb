class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(item_params)
    if @customer.save
      redirect_to customer_path(customer.id)
    else
      render :new
    end
  end


  def show
    # @customer = Customer.find(params[:id])
    @customer = current_customer

  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to mypage_customers_path
    # (＠customer)はURLniコロンがあるかで判断
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path

  end






  private

  def customer_params
    params.require(:customer).permit(:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active)

  end


end
