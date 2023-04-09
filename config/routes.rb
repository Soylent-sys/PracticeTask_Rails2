Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/sign_up',            to: 'users#new'
  post   '/sign_up',            to: 'users#create'
  get    'users/account',       to: 'users#show'
  get    'users/profile',       to: 'users#show'
  get    'users/edit',          to: 'users#edit'
  patch  'users/edit',          to: 'users#update'
  get    'users/profile/edit',  to: 'users#edit'
  patch  'users/profile/edit',  to: 'users#update'
  get    '/log_in',             to: 'sessions#new'
  post   '/log_in',             to: 'sessions#create'
  delete '/log_out',            to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
