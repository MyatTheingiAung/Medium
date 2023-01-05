Rails.application.routes.draw do
  get 'comment/index'
  get 'profile/index'
  post 'profile', to: 'profile#update'
  delete 'profile', to: 'profile#image_destroy'
  post 'profile/password', to: 'profile#change_password'
  get 'login', to: 'auth#login'
  post 'login', to: 'auth#user_login'
  get 'register', to: 'auth#register'
  post 'register', to: 'auth#create'
  delete 'logout', to: "auth#logout"
  get '/', to: "post#index"
  get 'post/create'
  post 'posts', to: "post#store"
  resources :post
  get 'post/:id', to: "post#show"
  get 'category/:name', to: "post#category_list"
  get 'search', to: "post#search"
  root 'post#index' 
  post 'comment', to: "post#comment_store"
  post 'comment/reply', to: "post#comment_reply"
  post 'comment/:id', to: "post#comment_edit"
  delete 'comment/:id', to: "post#comment_destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
