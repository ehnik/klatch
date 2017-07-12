Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
  get '/', to: 'devise/registrations#new'
  end

  resources :users do
    resources :articles do
      resources :comments, except: [:index]
    end
    end
  get '/user/:user_id/friendships', to: 'friendships#show', as: 'user_friends'
  get '/user/:user_id/friendships/new/:friend_id', to: 'friendships#add'
  get '/user/:user_id/articles/new/', to: 'articles#new',  as: 'articles_new'
  get '/user/:user_id/articles/create/', to: 'articles#create',  as: 'articles_create'
  get '/user/:user_id/articles/feed/', to: 'articles#feed', as: 'articles_feed'
  get '/user/:user_id/articles/', to: 'articles#index', as: 'articles_index'
  get '/user/:user_id/requests', to: 'requests#index', as: 'requests_index'
  get '/user/:user_id/requests/:requestee_id', to: 'requests#show', as: 'requests_show'
  get '/user/:user_id/requests/new', to: 'requests#new', as: 'requests_new'
  post '/user/:user_id/requests', to: 'requests#create', as: 'requests_create'
  delete '/user/:user_id/requests/:id', to: 'requests#destroy', as: 'requests_delete'
  put '/users/:user_id/articles/:id(.:format)', to: 'articles#update', as: 'articles_update'
  delete '/user/:user_id/articles/:id(.:format)', to: 'articles#destroy', as: 'delete_article'
  delete '/user/:user_id/friendships/delete/:friend_id', to: 'friendships#destroy', as: 'delete_friend'





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
