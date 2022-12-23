Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/show'
  root 'welcome#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
