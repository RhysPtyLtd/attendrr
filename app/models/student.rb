class Student < ApplicationRecord
  include ActiveModel::Dirty
  define_attribute_methods
  belongs_to :club
  belongs_to :payment_plan, optional: true
  default_scope -> { order(:last_name) }
  mount_uploader :picture, PictureUploader
  validates :club_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validate :picture_size
  before_save { email.downcase! }
  before_save { state.upcase! }
  #before_create :assign_prospect
  has_many :student_ranks, dependent: :destroy
  has_many :ranks, through: :student_ranks
  has_many :activities, through: :ranks
  accepts_nested_attributes_for :student_ranks
  has_many :attendances, dependent: :destroy
  before_save :handle_payment_plan_changes!

  scope :student_for_attendance, -> (rank_ids) { includes(:ranks).where(:ranks => {id: rank_ids}).distinct }
  scope :last_month,  -> (timeslot_id,date_find) { joins(sanitize_sql_array(['left outer join attendances on attendances.student_id = students.id'])).where('attendances.id is null OR (attendances.timeslot_id != ? AND attendances.attended_on != ?)',timeslot_id,date_find)}

  before_update :check_lost_students

  #can be used in queries in future by full name
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def buy_classes!
    self.classes_remaining = self.classes_remaining.to_i + self.payment_plan.classes_amount
    save
    create_revenue_record
  end

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

  def check_lost_students
    deactivate_status = self.active_changed? && self.active == false
    if deactivate_status
      DailyMetric.create(
        club_id: self.club.id,
        lost_students: 1
      )
    end
  end

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

    def handle_payment_plan_changes!
      return if created_at.nil?
      changes = self.changes
      if self.classes_remaining_changed?
        original_classes_amount = changes["classes_remaining"][0]
        updated_classes_amount = changes["classes_remaining"][1]
        if original_classes_amount.nil?
          self.classes_remaining = updated_classes_amount
        elsif updated_classes_amount.nil?
          self.classes_remaining = nil
        else
          self.classes_remaining = updated_classes_amount
          create_revenue_record
        end   
      end 
      if self.payment_plan_id_changed? && self.payment_plan.classes_amount.nil?
        self.classes_remaining = nil
      end
    end

    def create_revenue_record
      DailyMetric.create(
          club_id: self.club.id,
          revenue: self.payment_plan.price.to_f
        )
    end
end