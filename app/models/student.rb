class Student < ApplicationRecord
  belongs_to :club
  belongs_to :payment_plan, optional: true
  default_scope -> { order(:last_name) }
  mount_uploader :picture, PictureUploader
  validates :club_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
            length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX }
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postcode, presence: true
  validates :phone1, presence: true
  validates :dob, presence: true
  validate :picture_size
  before_save { email.downcase! }
  before_save { state.upcase! }
  before_create :assign_prospect
  has_many :student_ranks, dependent: :destroy
  has_many :ranks, through: :student_ranks
  accepts_nested_attributes_for :student_ranks
  has_many :attendances, dependent: :destroy

  scope :student_for_attendance, -> (rank_ids) { includes(:ranks).where(:ranks => {id: rank_ids}).distinct }
  scope :last_month,  -> (timeslot_id,date_find) { joins(sanitize_sql_array(['left outer join attendances on attendances.student_id = students.id'])).where('attendances.id is null OR (attendances.timeslot_id != ? AND attendances.attended_on != ?)',timeslot_id,date_find)}
  
  def last_attendance
    if self.attendances.any?
      self.attendances.order("created_at").last.attended_on.to_date
    else
      self.club.created_at.to_date
    end
  end


  def unique_activities
   student_activities.map(&:name).uniq
  end

  #def all_acitivities # SPELLING ERROR
   # activitys
  #end

  def club_ranks
    club_activities.map{ |a| a.ranks}.flatten
  end

  def all_ranks
    self.club.activities.map { |a| a.ranks}.flatten
  end

  def first_ranks_of_activities
    club_activities.map { |a| a.ranks.select{ |r| r.position == 0  }}.flatten
  end

  #def current_ranks
    # all ranks where active == true
  #end

  private

    def club_activities
      self.club.activities
    end
 
    def student_activities
     self.ranks.map(&:activity)
    end

    def assign_prospect
      self.payment_plan = self.club.payment_plans.first
    end

end