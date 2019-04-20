Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :mentors, only: [:index, :create]
      resources :mentees, only: [:update, :create]
    end
  end
end
