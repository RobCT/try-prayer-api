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
  resources :people, :only => [:show, :index, :create, :update, :destroy] do
    member do
      post 'roles', :to => 'people#add_role', :as => :add_role_to
      get 'roles', :to => 'people#show_roles', :as => :show_roles_for
      delete 'roles', :to => 'people#remove_role', :as => :remove_role_from
    end
  end
  resources :roles, :only => [:show, :index, :create, :update, :destroy]
  

  devise_scope :user do
      post 'registrations' => 'registrations#create', :as => 'register'
    end
    end
  end
end