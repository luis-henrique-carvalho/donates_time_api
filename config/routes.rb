Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: {
                                     sign_in: 'login',
                                     sign_out: 'logout',
                                     registration: 'signup'
                                   },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :ongs, only: %i[index show create update destroy]
      resources :actions, only: %i[index show create update destroy]
    end
  end
end
