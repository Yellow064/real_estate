require 'api_constraints'

Rails.application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # Api definition
  namespace :api, defaults: { format: :json }, path: '/api'  do
    # We are going to list our resources here
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default:true) do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy] do
        resources :houses, :only => [:create, :update, :destroy]
      end
      resources :sessions, :only => [:create, :destroy]
      resources :houses, :only => [:show, :index]
    end
  end
end
