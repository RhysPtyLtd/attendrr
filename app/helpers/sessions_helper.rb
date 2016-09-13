module SessionsHelper

	# Logs in given club
	def log_in(club)
		session[:club_id] = club.id
	end

	# Returns the current logged-in club (if any)
	def current_club
		@current_club ||= Club.find_by(id: session[:club_id])
	end

	# Returns true if the club is logged in, false otherwise
	def logged_in?
		!current_club.nil?
	end

	# Logs out the current user
	def log_out
		session.delete(:club_id)
		@current_club = nil
	end
end
