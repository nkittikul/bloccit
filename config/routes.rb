Bloccit::Application.routes.draw do
  
  devise_for :users

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :users, only: [:update]

  ##match "about", to: 'welcome#about', via: :get

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
