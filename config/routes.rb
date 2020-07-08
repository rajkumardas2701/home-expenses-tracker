Rails.application.routes.draw do
  devise_for :users
  root "welcome#index"
  resources :users, only: [:show] 
  get 'all_expenses', to: 'expenses#all_expenses'
  get 'all_external_expenses', to: 'expenses#all_external_expenses'
  get 'all_groups', to: 'groups#index'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
