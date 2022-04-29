Rails.application.routes.draw do
  
  
  devise_for :users, controllers: { sessions: :sessions },
                       path_names: { sign_in: :login }
  resource :user, only: [:update, :show]                     
  namespace :api do
    resources :robots
    post 'robot/:id/commands', to: 'robots#commands'  
  end
end
