class Student < ApplicationRecord
  belongs_to :club
  belongs_to :payment_plan, optional: true
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
  before_create :assign_prospect
  has_many :student_ranks
  has_many :ranks, through: :student_ranks

  def student_activities
    activitys.map(&:name).uniq
  end

  def first_ranks_of_activities
    club_activities.map { |a| a.ranks.select{ |r| r.position == 0  }}.flatten
  end

  def current_ranks
    # all ranks where active == true
  end

  private

    def club_activities
      self.club.activities
    end
 
    def activitys
      self.ranks.map(&:activity)
    end

    def assign_prospect
      self.payment_plan = self.club.payment_plans.first
    end

end