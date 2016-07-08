Rails.application.routes.draw do

  resources :user_sessions, only: :create do
    collection do
      delete :destroy
      post :create_with_token
    end
  end

  resources :users do
    collection do
      post :create_with_FB
    end
  end

  namespace :api, default: {format: :json} do
    resources :calendars, only: [:create, :index]
    resources :stamped_dates, only: [:create, :index]
  end
end
