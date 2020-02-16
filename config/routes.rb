Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/sessions' 
  get '/sessions', to: 'welcome#sessions'

  root 'welcome#index'
end
