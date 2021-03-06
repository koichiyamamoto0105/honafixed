Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    root 'maps#top'

    resources :users, except: [:index, :destroy] do
      member do
        get '/favorites' => 'users#favorites', as: 'favorites'
      end
    end
    resources :maps do
      resource :favorites, only: [:create, :destroy, :index]
      resources :comments, only: [:create, :destroy]
    end
    # get '/map/hashtag/:name', to: "maps#hashtag"
    get '/search', to: 'search#search'
  end
end
