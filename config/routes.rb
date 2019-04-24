Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :mentors, only: [:index, :create, :update, :destroy, :show]
      resources :mentees, only: [:update, :create, :destroy, :show]
    end
  end
end
