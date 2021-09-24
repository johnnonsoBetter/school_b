Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'Admin', at: 'auth'

      mount_devise_token_auth_for 'Student', at: 'student_auth'

      mount_devise_token_auth_for 'Teacher', at: 'teacher_auth'



      mount_devise_token_auth_for 'Guidance', at: 'guidance_auth'

      as :guidance do
        # Define routes for Guidance within this block.
        get 'guidance_dashboards', to: 'guidance_dashboards#index'
       
      end
      as :guidance do
        # Define routes for Guidance within this block.
      end
      as :teacher do
        # Define routes for Teacher within this block.
      end
      as :student do
        # Define routes for Student within this block.
      end

    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
