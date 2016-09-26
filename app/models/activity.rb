class Activity < ApplicationRecord
  belongs_to :club
  has_many :timeslots, dependent: :destroy
  accepts_nested_attributes_for :timeslots
  validates :club_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
end
