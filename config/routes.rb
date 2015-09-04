Rails.application.routes.draw do

  devise_for :users
  post 'add_members', to: 'members#add_members', as: 'import_members'

  root to: 'export#index'
end
