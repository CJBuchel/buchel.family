Rails.application.routes.draw do
  get 'scraper/index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  root to: "welcome#index"

  # Login
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get '/main/index' => "main#index", as: "main_index"

  # Minecraft Downloads
  get '/minecraft/index' => "minecraft#index", as: "minecraft_index"
  get 'download_modpack_ScienceBallz', to: 'minecraft#download_modpack_ScienceBallz'
  get 'download_resourcepack_ScienceBallz', to: 'minecraft#download_resourcepack_ScienceBallz'
  get 'download_forge_1_12_2', to: 'minecraft#download_forge_1_12_2'


  # Landing
  get '/welcome/index'
end