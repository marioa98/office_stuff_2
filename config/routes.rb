Rails.application.routes.draw do
  root 'stuffs#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'new_stuff', to: 'stuffs#new'
  get 'edit/:id', to: 'stuffs#edit', as: 'edit_stuff'
  get 'comments/:id', to: 'comments#index', as: 'comments_index'
  if Rails.env.development?
    get 'coverage', to: redirect("#{Rails.root}/public/coverage/index.html")
  end

  post 'new_stuff', to: 'stuffs#create'
  post 'comments/:id', to: 'comments#create', as: 'create_comment'
  
  patch 'edit/:id', to: 'stuffs#update', as: 'update_stuff'
end
