require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # Api definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
resources :users, :only => [:index, :show, :create, :update, :destroy] do
  

end
  resources :sessions, :only => [:create, :destroy]
  resources :prayers, :only => [:show, :index, :create, :update, :destroy] 
    resource :prayer, :only => [] do
      post 'calendar', :to => 'prayers#calendar', :as => :render_calendar
    end
  
  
  #resources :calendar, :only => [:create]

  devise_scope :user do
      post 'registrations' => 'registrations#create', :as => 'register'
    end
    end
  end
end