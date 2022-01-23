Rails.application.routes.draw do
  resources 'users', only: :index do
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end

  resources :projects do
    resources :messages, only: [:index, :create]
    resources :tasks, only: [:index, :create] do
      post 'complete', to: 'tasks#complete'
    end
  end
  devise_for :users,
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations",
    },
    path_names: {
      sign_in: 'sign-in', sign_out: 'sign-out',
      password: 'password', registration: '', sign_up: 'sign-up'
    }
  root to: "home#index"
end
