Rails.application.routes.draw do

  root to: "home#index"
  devise_for :users,
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations",
    },
    path_names: {
      sign_in: 'sign-in', sign_out: 'sign-out',
      password: 'password', registration: '', sign_up: 'sign-up'
    }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
