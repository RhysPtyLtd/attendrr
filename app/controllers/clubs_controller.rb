class ClubsController < ApplicationController

  def new
  	@club = Club.new
  end

  def create
  	@club = Club.new(club_params)
  	if @club.save
      flash[:success] = "#{@club.name} successfully created. Welcome to Class Master!"
  		redirect_to @club
  	else
  		render 'new'
  	end
  end

  def show
  	@club = Club.find(params[:id])
  end

  private

  	def club_params
  		params.require(:club).permit(:name, :email, :password, :password_confirmation)
  	end
end
