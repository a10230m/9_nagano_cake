Rails.application.routes.draw do

  get '/top' => 'homes#top'
  root to: 'homes#top'
  get '/about' => 'homes#about'


  # 会員側のルーティング設定

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  # 管理者側のルーティング設定
  namespace :admin do
    # 注文履歴一覧
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

  namespace :public do
    resources :customers, only: [:index, :edit, :update, :destroy, :withdraw]


    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "destroy_all"   #パスが　all_destroy_cart_items_path, method: :delete　となる
      end
    end

    resources :orders, only: [:new, :create, :index, :show]


  end


    get '/customers/mypage' => 'public/customers#show'
    get '/customers/confirm' => 'public/customers#confirm', as: 'confirm'
    patch '/customers/withdraw' => 'public/customers#withdraw', as: 'withdraw'
    post '/orders/confirm' => 'public/orders#confirm', as: 'orders/confirm'
    get '/orders/complete' => 'public/orders#complete', as: 'complete'











  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
