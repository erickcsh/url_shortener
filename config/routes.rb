# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # TODO: remove active storage routes
  namespace :api do
    namespace :v1 do
      resources :websites, only: [:show, :index, :create]
    end
  end
end
