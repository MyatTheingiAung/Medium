Rails.application.routes.draw do
  root 'posts#index' 
  get 'comment/index'
  get 'profile/:id', to: 'profile#index'
  post 'profile', to: 'profile#update'
  delete 'profile', to: 'profile#image_destroy'
  patch 'profile/password', to: 'profile#password'
  delete 'profile/image', to: 'profile#user_image_delete'
  get 'login', to: 'auth#login'
  post 'login', to: 'auth#user_login'
  get 'register', to: 'auth#register'
  post 'register', to: 'auth#create'
  delete 'logout', to: "auth#logout"
  get '/', to: "posts#index"
  get 'posts/create'
  post 'posts', to: "posts#store"
  resources :posts
  get 'posts/:id', to: "posts#show"
  get 'category/:name', to: "posts#category_list"
  post 'comment', to: "posts#comment_store"
  post 'comment/reply', to: "posts#comment_reply"
  post 'comment/:id', to: "posts#comment_edit"
  delete 'comment/:id', to: "posts#comment_destroy"
  # match "/404", to: "errors#not_found", via: :all
  # match "/500", to: "errors#internal_server_error", via: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
