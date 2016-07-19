Rails.application.routes.draw do
  
  get 'surveys/new'

  get 'people/new'
  post 'people/new' => 'people#create'
  resources :people
  
  get 'questions/new'
  get 'questions/index'
  post 'questions/new' => 'questions#create'
  
  get 'options/new'
  post 'options/new' => 'options#create'
  # resources :tests do 
  #   resources :questions
  # end
  
  get 'tests/new'
  resources :surveys
  resources :tests
  resources :questions
  root 'tests#index'
  get 'results' => 'surveys#results'
  patch 'tests' => 'tests#add_name'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
