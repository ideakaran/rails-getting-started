Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :games do
        resources :divisions do
          resources :teams
        end
      end
    end
  end
end
