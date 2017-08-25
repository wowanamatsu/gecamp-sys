Rails.application.routes.draw do
  get 'relatorios/index'

  resources :funcoes
  resources :profissoes
  resources :seguimentos
  resources :pessoas
  resources :users
  resources :relatorios
  resources :equipes

  devise_for :users, :skip => [:registrations, :sessions]

  as :user do
    get "/login" => "devise/sessions#new", :as => :new_user_session
    post "/login" => "devise/sessions#create", :as => :user_session
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  resources :estados
  resources :municipios
  resources :cidades
  resources :bairros

  root to: 'home#index'
end
