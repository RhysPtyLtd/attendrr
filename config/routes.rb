Rails.application.routes.draw do
	root 'static_pages#home'
    get '/signup', to: 'clubs#new'
    post '/signup', to: 'clubs#create'
	get  '/help',    to: 'static_pages#help'
    get  '/about',   to: 'static_pages#about'
    get  '/contact', to: 'static_pages#contact'
    resources :clubs
end
