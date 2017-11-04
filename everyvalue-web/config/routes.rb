Rails.application.routes.draw do
  resources :subject_attachments
  resources :valuations
  resources :hashtags
  resources :subjects
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
