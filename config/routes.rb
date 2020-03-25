Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'new_stuff', to: 'stuffs#new'
  get 'edit/:id', to: 'stuffs#edit', as: 'edit_stuff'

  post 'new_stuff', to: 'stuffs#create'
  
  patch 'edit/:id', to: 'stuffs#update', as: 'update_stuff'

  root 'stuffs#index'
end
