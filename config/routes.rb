Rails.application.routes.draw do
  
  resources :subjects
  get 'welcome/index'
  get '/sessions', to: 'sessions#show'
  post '/sessions/:subject', to: 'sessions#show', as: :sessions_show
  get '/sessions/:subject', to: 'sessions#show'
  root 'welcome#index'
end
