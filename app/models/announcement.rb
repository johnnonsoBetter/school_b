class Announcement < ApplicationRecord
  belongs_to :announcement_image
  belongs_to :school

  validates :message, presence: true
end
