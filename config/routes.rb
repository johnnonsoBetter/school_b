Rails.application.routes.draw do
 
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'Admin', at: 'auth'

      mount_devise_token_auth_for 'Student', at: 'student_auth'

      mount_devise_token_auth_for 'Teacher', at: 'teacher_auth'

      mount_devise_token_auth_for 'Guidance', at: 'guidance_auth'

      resources :products
      resources :photos
      resources :notifications

      get 'vapid_keys', to: 'vapid_keys#index'

      resources :classrooms, only: [:create, :index, :show]
      resources :subjects, only: [:create, :index, :show]
      resources :bill_reports, only: [:create, :index]
      get 'debtors', to: 'debtors#index'
      get 'debt_bills', to: 'debt_bills#index'
      get 'admin_dashboards', to: 'admin_dashboards#index'
      get 'admin_student_score_reports', to: 'admin_student_score_reports#index'
      get 'admin_student_behaviour_reports', to: 'admin_student_behaviour_reports#index'
      get 'admin_student_bills', to: 'admin_student_bills#index'
      resources :items, only: [:create, :update, :destroy, :show, :index]
      resources :restock_reports, only: [:create, :index]
      resources :expense_reports, only: [:create, :index]
      resources :stock_repair_reports, only: [:create, :index]
      resources :sale_reports, only: [:create, :index]
      resources :debt_recovered_reports, only: [:create, :index]
      resources :students, only: :index
      resources :teachers, only: :index

      as :guidance do
        # Define routes for Guidance within this block.
        get 'guidance_dashboards', to: 'guidance_dashboards#index'
        get 'guidance_score_reports', to: 'guidance_score_reports#index'
        get 'guidance_behaviour_reports', to: 'guidance_behaviour_reports#index'
        resources :guidance_bills, only: [:index, :show]
      end

      as :teacher do
        # Define routes for Teacher within this block.
        resources :teacher_behaviour_reports, only: [:create, :index]
        resources :teacher_score_reports, only: [:create, :index]
        resources :score_report_drafts, only: [:create, :index, :show]
        put 'student_score_report_drafts/:id', to: 'student_score_report_drafts#update'
        get 'student_score_report_drafts', to: 'student_score_report_drafts#index'
        post 'publish_drafts', to: 'publish_drafts#create'
        get 'teacher_dashboards', to: 'teacher_dashboards#index'
        get 'teacher_classroom_students', to: 'teacher_classroom_students#index'

      end
      as :student do
        # Define routes for Student within this block.
      end

    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
