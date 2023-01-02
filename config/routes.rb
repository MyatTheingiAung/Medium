Rails.application.routes.draw do
  get 'welcome/index'
  get 'profile/index'
  get 'login', to: 'auth#login'
  post 'login', to: 'auth#userLogin'
  get 'register', to: 'auth#register'
  post 'register', to: 'auth#create'
  delete 'logout', to: "auth#logout"
  get '/', to: "post#index"
  get 'post/create'
  post 'posts', to: "post#store"
  resources :post
  get 'post/show'
  get 'category/:name', to: "post#category_list"
  get 'search', to: "post#search"
  root 'post#index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
