Bloccit::Application.routes.draw do
  
  devise_for :users

  resources :topics do
    resources :posts, except: [:index]
  end

  ##match "about", to: 'welcome#about', via: :get

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
