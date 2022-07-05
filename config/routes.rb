Rails.application.routes.draw do
  get 'homes/top'

  # 会員側のルーティング設定


  # 管理者側のルーティング設定
  namespace :admin do
    resources :items, only: [:new, :index, :show, :edit]
end



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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
