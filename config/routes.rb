Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :subscriptions, only: [:create, :destroy, :index]
    end
  end

  namespace :api do
    namespace :v0 do
      resources :customers do
        resources :subscriptions, only: [:index]
      end
    end
  end
end
