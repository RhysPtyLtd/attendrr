Rails.application.routes.draw do

  get 'charges/new'
  get 'charges/create'
  resources :subscriptions do
    collection do
      get :cancel
      get :change
      get :confirm_plan_change
      get :admin
    end
  end
  root 'static_pages#home'
  get '/signup', to: 'clubs#new'
  post '/signup', to: 'clubs#create'
  get '/metrics', to: 'clubs#metrics'
  get  '/help',    to: 'static_pages#help'
  get '/admin', to: 'static_pages#admin'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :clubs
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :students do
    collection do
      get 'attendance'
      get 'schedule_classes'
      get 'student_attendance'
      get 'prospects'
      get 'deactivated'
      get 'absents'
    end
    patch :buy_classes, on: :member
  end
  resources :activities do
    collection do
      get 'scheduled_classes'
      get 'students'
    end
    member do
      get :grading
            put :update_grading
    end
  end
  resources :timeslots
  resources :ranks
  resources :payment_plans
  resource :demo, only: :show, controller: :demo
  resources :charges, only: [:new, :create, :delete]
  get 'thanks', to: 'charges#thanks', as: 'thanks'
  resources :blog_posts do
    collection do
      get 'admin'
    end
  end
end
