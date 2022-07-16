class Public::CustomersController < ApplicationController


  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(item_params)
    if @customer.save
      redirect_to public_customer_path(customer.id)
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
    redirect_to customers_mypage_path(@customer)
  end



  private

  def customer_params
    params.require(:customer).permit(:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active)

  end


end
