

class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::ImplicitRender # if you need render .jbuilder
  include ActionView::Layouts # if you need layout for .jbuilder
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :image, :middle_name, :lga, :address, :state, :religion, :classroom_id, :date_of_birth, :date_of_admission, :gender, :admission_no])
  end

end
