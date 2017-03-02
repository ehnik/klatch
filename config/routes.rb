Rails.application.routes.draw do
  #get '/', to: 'articles#index', as: 'articles'
  devise_for :users
  resources :users do
    resources :articles do
      resources :comments, except: [:index]
    end
    end
  get '/user/:user_id/friendships', to: 'friendships#show', as: 'user_friends'
  get '/user/:user_id/friendships/new', to: 'friendships#new', as: 'user_new_friend'
  get '/user/:user_id/friendships/new/:friend_id', to: 'friendships#add'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
