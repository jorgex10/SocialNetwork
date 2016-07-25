Rails.application.routes.draw do

  devise_for :users

  namespace :v1, defaults: { format: :json } do
    resources :users do
      get :me, on: :collection
    end
    resources :messages, only: [:create, :show] do
      collection do
        get :sent
        get :unread
        get :read
      end
    end
    resources :sessions, only: :create
  end

end
