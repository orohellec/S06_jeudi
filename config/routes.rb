Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  post '/', to: 'home#create'
  get '/result', to: 'home#result'
end
