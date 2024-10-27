Rails.application.routes.draw do
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
        resources :actions, only: %i[index], controller: 'users/actions'
      end

      resources :chats, only: %i[] do
        resources :messages, only: %i[index create], controller: 'chats/messages'
      end

      resources :actions, only: %i[index show create update destroy] do
        resources :volunteers, only: %i[index], controller: 'actions/volunteers'
      end
      resources :volunteers, only: %i[show create destroy]
    end
  end

  mount ActionCable.server => '/chat'
end
