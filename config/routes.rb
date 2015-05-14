Rails.application.routes.draw do
  root to: "bands#index"
  resources :users, only: [:new, :create, :show] do
    collection do 
      get 'activate'
    end
  end
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: [:new]
  end
  resources :albums, except: [:new, :index] do
    resources :tracks, only: [:new]
  end
  resources :tracks, expcet: [:new, :index]
  resources :notes, only: [:create, :destroy]
end
