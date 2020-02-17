Rails.application.routes.draw do
  
  get 'welcome/index'
  get '/sessions', to: 'sessions#show'
  post '/sessions/:bool', to: 'sessions#show', as: :sessions_show
  get '/sessions/:bool', to: 'sessions#show'
  root 'welcome#index'
end
