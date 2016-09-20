class Student < ApplicationRecord
  belongs_to :club
  default_scope -> { order(:last_name) }
  mount_uploader :picture, PictureUploader
  validates :club_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postcode, presence: true
  validates :phone1, presence: true
  validates :dob, presence: true
  validate :picture_size
end