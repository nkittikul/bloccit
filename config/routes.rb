Bloccit::Application.routes.draw do
  
  devise_for :users

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end
  end

  resources :users, only: [:update]

  ##match "about", to: 'welcome#about', via: :get

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
