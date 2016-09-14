module SessionsHelper

	# Logs in given club
	def log_in(club)
		session[:club_id] = club.id
	end

	# Remembers a club in a persistent session
	def remember(club)
		club.remember
		cookies.permanent.signed[:club_id] = club.id
		cookies.permanent[:remember_token] = club.remember_token
	end

	# Returns the club corresponding to the remember token cookie
	def current_club
		if (club_id = session[:club_id])
			@current_club ||= Club.find_by(id: club_id)
		elsif (club_id = cookies.signed[:club_id])
			club = Club.find_by(id: club_id)
			if club && club.authenticated?(cookies[:remember_token])
				log_in club
				@current_club = club
			end
		end
	end

	# Returns true if the club is logged in, false otherwise
	def logged_in?
		!current_club.nil?
	end

	# Forgets a persistent session
	def forget(club)
		club.forget
		cookies.delete(:club_id)
		cookies.delete(:remember_token)
	end

	# Logs out the current user
	def log_out
		forget(current_club)
		session.delete(:club_id)
		@current_club = nil
	end
end
