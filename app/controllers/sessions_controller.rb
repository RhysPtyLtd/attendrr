class SessionsController < ApplicationController

  def new
  end

  def create
  	@club = Club.find_by(email: params[:session][:email].downcase)
  	if @club && @club.authenticate(params[:session][:password])
  		log_in @club
      params[:session][:remember_me] == '1' ? remember(@club) : forget(@club)
  		redirect_to @club
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
