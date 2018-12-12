Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'schedules#index'

  resources :schedules do
    member do
      get :toggle_status
    end
  end

  resources :events do
    member do
      get :toggle_status
    end
  end

  resources :user_sessions do
    collection do
      get :new
      post :create
      get :logout
      get :signup
    end
  end

  resources :users do
    collection do
      post :create
    end
  end

  namespace :public do
    namespace :api do
      resources :events, only: [] do
        collection do
          post :trigger
        end
      end
    end
  end

  match 'login', to: 'user_sessions#new', via: :all
  match 'logout', to: 'user_sessions#logout', via: :all
  match 'signup', to: 'user_sessions#signup', via: :all
end