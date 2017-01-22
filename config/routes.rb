Rails.application.routes.draw do
#  get 'sponsored_posts/show'

#  get 'sponsored_posts/new'

#  get 'sponsored_posts/edit'

#  get 'posts/index'

#  get 'posts/show'

#  get 'posts/new'

#  get 'posts/edit'

resources :topics do
  resources :sponsored_posts, except: [:index]
end

resources :topics do
    resources :posts, except: [:index]
end


#  get 'welcome/index'

#  get 'welcome/about'
get 'about' => 'welcome#about'

  root 'welcome#index'

 
end
