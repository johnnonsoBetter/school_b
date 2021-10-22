# frozen_string_literal: true

class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :update_full_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one_attached :image

  belongs_to :school
  belongs_to :classroom
  has_and_belongs_to_many :guidances
  has_many :bills
  has_many :score_reports
  has_many :behaviour_reports
  belongs_to :classroom

  validates :image, presence: true

  private 
  def update_full_name 
    self.full_name = "#{first_name} #{middle_name} #{last_name}"
    
  end
end
