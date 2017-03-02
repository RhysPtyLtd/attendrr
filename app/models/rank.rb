class Rank < ApplicationRecord
  belongs_to :activity, optional: true
  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :position, presence: true
  default_scope -> { order(position: :asc) }
  has_many :student_ranks
  has_many :students, through: :student_ranks
end
