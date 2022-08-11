Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  scope module: :public do
    root :to =>"homes#top"
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdraw' => 'users#withdraw', as: 'withdraw'
    get 'blogs/electric' => 'blogs#electric', as: 'electric'
    get 'blogs/interior' => 'blogs#interior', as: 'interior'
    get 'blogs/tableware' => 'blogs#tableware', as: 'tableware'
    get 'blogs/food' => 'blogs#food', as: 'food'
    delete 'tags/:id' => 'tags#destroy', as: 'tag'
    resources :blogs do
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update, :index]
    get '/search', to: 'searches#search'
  end

  namespace :admin do
    get '/blogs/tag' => 'blogs#tag', as: 'tag'
    resources :users, only: [:index, :show, :edit, :update]
    resources :blogs, only: [:index, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
