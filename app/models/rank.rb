class Rank < ApplicationRecord
  belongs_to :activity, optional: true
  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :position, presence: true
  default_scope -> { order(position: :asc) }
end
