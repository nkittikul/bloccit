Bloccit::Application.routes.draw do
  
  get "comments/create"
  get "tests/index"
  get "tests/show"
  get "tests/new"
  get "tests/edit"
  devise_for :users

  resources :topics do
    resources :posts, except: [:index] do
      resource :comments, only: [:create]
    end
  end

  resources :users, only: [:update]

  ##match "about", to: 'welcome#about', via: :get

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
