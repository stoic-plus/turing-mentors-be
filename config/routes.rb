Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :mentors, only: [:index, :create, :update]
      resources :mentees, only: [:update, :create, :destroy]
    end
  end
end
