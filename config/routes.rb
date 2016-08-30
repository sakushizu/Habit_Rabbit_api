Rails.application.routes.draw do
  namespace :api, default: {format: :json} do
    resources :calendars, only: [:index, :create, :update]
    resources :memos, only: [:index, :create]
    resources :stamped_dates, only: [:create, :index, :destroy] do
      collection do
        get :calendar_users_ranking
      end
    end
    resources :user_sessions, only: :create do
      collection do
        delete :destroy
        post :create_with_token
      end
    end

    resources :users do
      collection do
        post :create_with_fb
        get :not_joined_users
      end
      resources :calendar_users, only: :create do
        collection do
          get :inviting_calendar
          patch :reject
        end
      end
    end
  end
end
