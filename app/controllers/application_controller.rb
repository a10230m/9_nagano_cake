class ApplicationController < ActionController::Base


  # before_action :authenticate_customer!, except: [:top, :about]
  # before_action :configure_permitted_parameters, if: :devise_controller?


  protected





  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_items_path
    when Customer
      customers_mypage_path
    end
  end

  # def after_sign_up_path_for(resource)
    # case resource
    # when Admin
      # admin_path
    # when Customer
      # public_end_users_show_path
    # end
  # end

  # def after_sign_out_path_for(resource)
    # if resource == :admin
      # new_admin_session_path
    # else
    # root_path
    # end
  # end


end


