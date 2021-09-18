Rails.application.routes.draw do
  mount_devise_token_auth_for 'Admin', at: 'auth'

  mount_devise_token_auth_for 'Student', at: 'student_auth'

  mount_devise_token_auth_for 'Teacher', at: 'teacher_auth'
  as :teacher do
    # Define routes for Teacher within this block.
  end
  as :student do
    # Define routes for Student within this block.
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
