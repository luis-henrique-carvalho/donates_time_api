Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :users do
        get 'ong/index'
      end
    end
  end
  devise_for :users, path: 'auth', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'auth/sessions',
    registrations: 'auth/registrations'
  }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :ongs, only: %i[index show create update destroy] do
        resources :actions, only: %i[index], controller: 'ongs/actions'
        resources :volunteers, only: %i[index], controller: 'ongs/volunteers' do
          put :confirm_presence, on: :member
        end
      end

      resources :users, only: %i[show] do
        resources :ong, only: %i[index], controller: 'users/ong'
      end

      resources :actions, only: %i[index show create update destroy] do
        resources :volunteers, only: %i[index], controller: 'actions/volunteers'
      end
      resources :volunteers, only: %i[show create destroy]
    end
  end
end
