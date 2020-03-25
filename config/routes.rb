Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'new_stuff', to: 'stuffs#new'

  post 'new_stuff', to: 'stuffs#create'

  root 'stuffs#index'
end
