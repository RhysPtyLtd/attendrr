class Activity < ApplicationRecord
  belongs_to :club
  validates :club_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
end
