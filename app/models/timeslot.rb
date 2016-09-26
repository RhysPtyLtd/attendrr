class Timeslot < ApplicationRecord
	belongs_to :activity, optional: true
	validates :time_start, presence: true
	validates :time_end, presence: true
	validates :day, presence: true
	#validates :activity_id, presence: true
	default_scope -> { order(day: :asc) }
end
