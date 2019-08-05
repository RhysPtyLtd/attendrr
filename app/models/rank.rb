class Rank < ApplicationRecord
  belongs_to :activity, optional: true
  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  default_scope -> { order(position: :asc) }
  has_many :student_ranks
  has_many :students, through: :student_ranks
  before_create :assign_position
end

def activity_name
    self.activity.name
end

def num_of_ranks_in_activity
	self.activity.ranks.count
end

	private
		def assign_position
			self.position = num_of_ranks_in_activity + 1
		end
