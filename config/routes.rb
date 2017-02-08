Rails.application.routes.draw do
#  get 'posts/index'

#  get 'posts/show'

#  get 'posts/new'

#  get 'posts/edit'

resources :topics do
    resources :posts, except: [:index]
end

resources :posts, only: [] do
  resources :comments, only: [:create, :destroy]

  post '/up-vote' => 'votes#up_vote', as: :up_vote
  post '/down-vote' => 'votes#down_vote', as: :down_vote
end


   
   
resources :users, only: [:new, :create]
resources :sessions, only: [:new, :create, :destroy]

#  get 'welcome/index'

#  get 'welcome/about'
get 'about' => 'welcome#about'

  root 'welcome#index'

 
end
