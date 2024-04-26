Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'homes#guest_sign_in'
  end

  namespace :admins do
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end

  scope module: :users do
    get '/search', to: 'posts#search'
    resources :users, only: [:show, :edit, :update]
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end
  end

  root to: 'homes#top'
end
