class School < ApplicationRecord
    validates :name, presence: true
    has_many :admins
    has_many :students 
    has_many :teachers
    has_many :classrooms
    has_many :score_types
    has_many :bill_reports
    has_many :items
    has_many :restock_reports
    has_many :stock_repair_reports
    has_many :expense_reports
    has_many :sale_reports
    has_many :debt_recovered_reports
    has_many :announcements  
end
