Rails.application.routes.draw do
  namespace :api, default: {format: :json} do
    resources :calendars, only: [:index, :create, :update]
    resources :stamped_dates, only: [:create, :index, :destroy]
    resources :calendar_users, only: :create
    resources :user_sessions, only: :create do
      collection do
        delete :destroy
        post :create_with_token
      end
    end

    resources :users do
      collection do
        post :create_with_FB
        get :not_joined_users
      end
      resources :invitation_users, only: :index do
        collection do
          post :reject
        end
      end

    end
  end
end
