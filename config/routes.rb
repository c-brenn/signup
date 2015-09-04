Rails.application.routes.draw do

  devise_for :users
  post 'add_members', to: 'members#add_members', as: 'import_members'
  get 'export', to: 'export#index', as: 'export_members'
  root to: 'application#redirect_to_export'
end
