Rails.application.routes.draw do

  root 'static#index'

  resources :listings, controller: 'listings' #except: [:index] -> will show everything except index
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create] # will only show create route

  resources :users, controller: "users", only: [:create, :update, :edit, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get '/verify/:listing_id' => "listings#verify", as: "verify"
  get '/unverify/:listing_id' => "listings#unverify", as: "unverify"

end
