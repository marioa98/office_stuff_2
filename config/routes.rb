Rails.application.routes.draw do
  root 'stuffs#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'new_stuff', to: 'stuffs#new'
  get 'edit/:id', to: 'stuffs#edit', as: 'edit_stuff'
  get 'login', to: 'sessions#new', as: 'new_session'
  get 'comments/:id', to: 'comments#index', as: 'comments_index'
  get 'signin', to: 'users#new', as: 'new_user'
  get 'users', to: 'users#index', as: 'users_index'
  get 'profile', to: 'users#profile', as: 'my_profile'
  get 'details/:id', to: 'stuffs#details', as: 'stuff_details'

  if Rails.env.development?
    get 'coverage', to: redirect("#{Rails.root}/public/coverage/index.html")
  end

  post 'new_stuff', to: 'stuffs#create'
  post 'comments/:id', to: 'comments#create', as: 'create_comment'
  post 'signin', to: 'users#create', as: 'create_user'
  post 'login', to: 'sessions#login', as: 'create_session'
  post 'users/:id', to: 'users#to_admin', as: 'to_admin'
  post 'profile', to: 'users#update_profile', as: 'update_profile'
  
  patch 'edit/:id', to: 'stuffs#update', as: 'update_stuff'

  delete 'logout', to: 'sessions#logout', as: 'logout'
end
