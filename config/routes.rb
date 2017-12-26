Rails.application.routes.draw do

  resources :tasks

  devise_for :users, skip: [:sessions], :controllers => {passwords: "passwords", registrations: "users"}
  as :user do
    get "/login", to: "sessions#new", as: :new_user_session
    post "/login", to: "sessions#create", as: :user_session
    delete "/logout", to: "sessions#destroy", as: :destroy_user_session
  end

  as :user do
    delete "/users/:id", to: "users#destroy", as: :user
    get "/trainer", to: "users#index", as: :user_trainer
    get "/trainee", to: "users#index", as: :user_trainee
    get "/users/:id", to: "users#show"
    # delete "/logout", to: "sessions#destroy", as: :destroy_user_session
  end

  as :course do
    get "/mycourse/:id", to: "trainee/courses#show", as: :trainee_course_view
    get "/mycourses", to: "trainee/courses#index"
    get "/course/new", to: "courses#new", as: :abcd
    get "/courses/:id", to: "courses#show"
    as :subjects do
      get "/mycourse/:course_id/subjects/:subject_id", to: "trainee/subjects#show", as: :show_subject_in_course
    end
  end

  patch "/update_progress/:id", to: "trainee/user_tasks#update", as: :user_task
  root to: "static_pages#home"
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
  post "/del_course_subject", to: "course_subjects#del_course_subjects"
  get "/profiles/:id", to: "trainee/users#show", as: :profile
  get "/profiles/:id/edit", to: "profiles#edit", as: :edit_profile
  put "profiles/:id", to: "profiles#update", as: :update_profile
  patch "profiles/:id", to: "profiles#updateAvatar", as: :avatar
  get "/courses/status", to: "courses#change_status", as: :course_status
end
