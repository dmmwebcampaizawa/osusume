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

  scope module: :public do
    root :to =>"homes#top"
    get 'users/my_page' => 'users#show', as: 'my_page'
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :users, only: [:show, :edit, :update]
    resources :blogs, only: [:new, :index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    get '/search', to: 'searches#search'
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :blogs, except: [:index, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
