Rails.application.routes.draw do

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
