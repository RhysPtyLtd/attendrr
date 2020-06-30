class NewClubMailer < ApplicationMailer

	def new_club_alert
		mail to: "rhys@attendrr.com", subject: "New club!"
	end
end
