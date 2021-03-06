# frozen_string_literal: true

class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :update_full_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  # validates :first_name, :last_name, :middle_name, :image, :date_of_admission, :date_of_birth, :religion, :state, :lga, :address, presence: true

  

  belongs_to :school
  belongs_to :classroom
  has_and_belongs_to_many :guidances
  has_many :bills
  has_many :score_reports
  has_many :behaviour_reports
  has_many :attendances


  
  private 
  def update_full_name 
    self.full_name = "#{first_name} #{middle_name} #{last_name}"
    
  end
end
