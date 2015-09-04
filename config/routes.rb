Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  post 'add_members', to: 'members#add_members', as: 'import_members'
  get 'export', to: 'export#index', as: 'export_members'
  get 'get_token', to: 'access#index', as: 'get_token'
  root to: 'export#index'
end
