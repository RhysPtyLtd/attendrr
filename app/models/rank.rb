class Rank < ApplicationRecord
  belongs_to :activity, optional: true
  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  default_scope -> { order(position: :asc) }
  has_many :student_ranks
  has_many :students, through: :student_ranks
  before_create :assign_position
  after_update :check_deactivated
end

def activity_name
    self.activity.name
end

def num_of_ranks_in_activity
	self.activity.ranks.where(active: true).count
end

	private

		# Assigns position to rank
    def assign_position
			self.position = num_of_ranks_in_activity + 1
		end

    # Ensures positions remain in order
    def check_deactivated
      if active_changed? and !active
        self.activity.ranks.where(active: true).where('position > ?', self.position).update_all('position = position-1')
      end
    end