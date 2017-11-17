Rails.application.routes.draw do

  devise_for :users, skip: [:sessions, :registrations], :controllers => {passwords: "passwords"}
  as :user do
    get "/login", to: "sessions#new", as: :new_user_session
    post "/login", to: "sessions#create", as: :user_session
    delete "/logout", to: "sessions#destroy", as: :destroy_user_session
  end

  as :user do
    get "/signup", to: "users#new", as: :signup
    post "/signup", to: "users#create", as: :user_registration
    get "/trainer", to: "users#index", as: :user_trainer
    get "/trainee", to: "users#index", as: :user_trainee
    get "users/:id/edit", to: "users#edit", as: :edit_user
    delete "users/:id", to: "users#destroy", as: :user
    # delete "/logout", to: "sessions#destroy", as: :destroy_user_session
  end

  root to: "courses#index", option: "2"
  get "/introduction", to: "intro_pages#home"
  get "/login", to: "session#new"
  post "/login", to: "session#create"
  delete "/logout", to: "session#destroy"
  resources :subjects
  resources :courses
  resources :course_subjects, only: [:create, :update, :destroy, :index]
  resources :user_courses, only: [:create, :update, :destroy, :index]
  patch "/define_action", to: "course_subjects#define_action"
  post "/del_user_courses", to: "user_courses#del_user_courses"
end
