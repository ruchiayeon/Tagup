Rails.application.routes.draw do
  
  
  mount RailsAdmin::Engine => '/ruchiayeon', as: 'rails_admin'
  devise_for :users
 root 'posts#index'
  
  get 'tags/:tag', to: 'posts#index', as: :tag, :constraints  => { :tag => /[^\/]+/ }
  resources :posts
  
  resources :comments
  resources :boards 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
