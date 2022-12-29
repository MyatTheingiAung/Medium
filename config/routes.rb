Rails.application.routes.draw do
  get 'home', to: 'welcome#index'
  get 'profile/index'
  get 'login', to: 'auth#login'
  post 'login', to: 'auth#userLogin'
  get 'register', to: 'auth#register'
  post 'register', to: 'auth#create'
  delete 'logout', to: "auth#logout"
  get 'post/create'
  get 'post/list'
  get 'post/show'
  get 'post/list_by_category'
  root 'welcome#index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
