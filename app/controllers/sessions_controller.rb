class SessionsController < ApplicationController

  def new
  end

  def create
  	@club = Club.find_by(email: params[:session][:email].downcase)
  	if @club && @club.authenticate(params[:session][:password])
      if @club.activated?
    		log_in @club
        params[:session][:remember_me] == '1' ? remember(@club) : forget(@club)
    		redirect_back_or root_url
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
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
