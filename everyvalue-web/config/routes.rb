Rails.application.routes.draw do
  resources :comments
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :subjects do
    collection do
      get 'comment'
    end
  end
  resources :valuations
  resources :hashtags
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :subject_attachments

  root 'root#home'
end
