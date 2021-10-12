# frozen_string_literal: true

class Teacher < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :update_full_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  belongs_to :school
  has_many :subjects
  has_many :classrooms, through: :subjects
  has_many :behaviour_reports
  has_many :score_reports
  has_many :score_report_drafts

  private 
  def update_full_name 
    self.full_name = "#{first_name} #{middle_name} #{last_name}"
    
  end
end
