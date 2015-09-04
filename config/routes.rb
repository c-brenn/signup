Rails.application.routes.draw do

  post 'add_members', to: 'members#add_members', as: 'import_members'
end
