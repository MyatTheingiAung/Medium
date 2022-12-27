Rails.application.routes.draw do
  get 'welcome/index'
  get 'profile/index'
  get 'auth/login'
  get 'auth/register'
  get 'post/create'
  get 'post/list'
  get 'post/show'
  get 'post/list_by_category'
  root 'welcome#index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
