Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/mentors', to: 'mentors#index'
    end
  end
end
