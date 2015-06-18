Bloccit::Application.routes.draw do
  
  devise_for :users

  resources :posts, only: [:index]
  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments, only: [:create, :destroy]
      post '/up-vote' => 'votes#up_vote', as: :up_vote
      post '/down-vote' => 'votes#down_vote', as: :down_vote
      resources :favorites, only: [:create, :destroy]
    end
  end

  resources :users, only: [:show, :index, :update]

  ##match "about", to: 'welcome#about', via: :get

  root to: 'welcome#index'
end
