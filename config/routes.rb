Rails.application.routes.draw do
  devise_for :users,
              controllers: {
                registrations: 'api/v1/users',
                sessions: 'api/v1/sessions'
              }
  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        scope module: 'account' do
          resources :users, only: [:show, :create, :update]
          resources :profiles, only: [:index, :show, :create, :update]
          resources :sessions, only: [:create, :destroy]
        end
        scope module: 'follower' do
          resources :followers, only: [:index, :create, :destroy]
          get "profile/:user_id/followers" => "followers#index"

        end
      end
    end
  end
end