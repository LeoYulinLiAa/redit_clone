Rails.application.routes.draw do

  resources :users, only: %i[show new create]
  resource :session, only: %i[new create destroy]
  resources :subs, only: %i[index show new create edit update]
  resources :posts, only: %i[show new create edit update destroy]

end
