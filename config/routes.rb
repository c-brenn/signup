Rails.application.routes.draw do

  get 'export', to: 'export#index', as: 'export_members'
  # export page at '/' -> protected by devise
  root to: 'export#index'

  namespace :api do
    post 'members/import', to: 'members#add_members', as: 'import_members'
    get 'access', to: 'access#index', as: 'get_token'
  end

  # rails admin interface
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # default devise routes for user signin
  devise_for :users
end

