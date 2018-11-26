Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  namespace :admin do
    resources :organizations do
      resources :missions do
        resources :applications, only: [:index]
      end
    end
  end

  resources :organizations, only: [:index, :show]

  namespace :account do
    resource :profile, only: [:show, :edit, :update]
    resources :missions, only: [:index]
  end

  resources :missions, only: [:index, :show] do
    resources :applications, only: [:create]
  end
end
