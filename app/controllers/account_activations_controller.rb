class AccountActivationsController < ApplicationController

	def edit
		club = Club.find_by(email: params[:email])
		if club && !club.activated? && club.authenticated?(:activation, params[:id])
			club.activate
			log_in club
			flash[:success] = "Account activated!"
			redirect_to subscriptions_path
		else
			flash[:danger] = "Invalid activation link" unless club.activated?
			redirect_to root_url
		end
	end

end