Rails.application.routes.draw do
	root 'static_pages#home'
    get '/signup', to: 'clubs#new'
    post '/signup', to: 'clubs#create'
	get  '/help',    to: 'static_pages#help'
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
        end
    end
    resources :activities do 
        collection do
            get 'scheduled_classes'
        end
    end
    resources :timeslots
    resources :ranks
    resources :payment_plans
end
