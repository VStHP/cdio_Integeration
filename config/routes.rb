Rails.application.routes.draw do
  devise_for :users, skip: [:sessions], :controllers => {passwords: "passwords"}
  as :user do
    get "/login", to: "sessions#new", as: :new_user_session
    post "/login", to: "sessions#create", as: :user_session
    delete "/logout", to: "sessions#destroy", as: :destroy_user_session
  end
  root to: "courses#index", option: "2"
  get "/introduction", to: "intro_pages#home"
  get "/login", to: "session#new"
  post "/login", to: "session#create"
  delete "/logout", to: "session#destroy"
  resources :courses
  resources :course_subjects, only: [:create, :update, :destroy]
end
