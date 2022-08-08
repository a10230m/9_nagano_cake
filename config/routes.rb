Rails.application.routes.draw do

  get '/top' => 'homes#top'
  root to: 'homes#top'
  get '/about' => 'homes#about'

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }



  # 管理者側のルーティング設定
  namespace :admin do
    # 注文履歴一覧
    root to: 'homes#top'
    # patch 'orders/:id' => 'order_details#update'
    resources :homes, only: [:top]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end



# public
    scope module: :public do
      # post '/customers' => 'customers#create'

      get '/items' => 'items#index'
      get '/items/:id' => 'items#show', as: 'item'


      resource :customers, only:[:edit, :update] do
        collection do
          get 'mypage' => 'customers#show', as: 'mypage'
          get :confirm
          patch 'withdraw' => 'customers#withdraw', as: 'withdraw'
        end
      end
      # get '/customers/mypage' => 'customers#show'
      # get '/customers/mypage/edit' => 'customers#edit', as: 'customer'
      # patch '/customers/mypage' => 'customers#update'
      # get '/customers/confirm' => 'customers#confirm', as: 'confirm'
      # patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'

      get '/cart_items' => 'cart_items#index', as: 'cart_items'
      post '/cart_items' => 'cart_items#create'
      patch '/cart_items/:id' => 'cart_items#update', as: 'cart_item'
      delete '/cart_items/:id' => 'cart_items#destroy'
      delete '/cart_items' => 'cart_items#destroy_all', as: 'destroy_all'

      get '/orders/new' => 'orders#new'
      post '/orders/confirm' => 'orders#confirm', as: 'orders/confirm'
      get '/orders/complete' => 'orders#complete', as: 'complete'
      post '/orders' => 'orders#create'
      get '/orders' => 'orders#index'
      get '/orders/:id' => 'orders#show', as: 'order'





    end



  # 会員側のルーティング設定

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }










  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
