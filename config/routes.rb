Rails.application.routes.draw do
#  get 'posts/index'

#  get 'posts/show'

#  get 'posts/new'

#  get 'posts/edit'

resources :topics do
    resources :posts, except: [:index]
end

resources :users, only: [:new, :create]
post 'users/confirm' => 'users#confirm'

#  get 'welcome/index'

#  get 'welcome/about'
get 'about' => 'welcome#about'

  root 'welcome#index'

 
end
