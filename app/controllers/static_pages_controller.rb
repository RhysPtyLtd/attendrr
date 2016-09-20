class StaticPagesController < ApplicationController
  def home
  	@student = current_club.students.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
  
end