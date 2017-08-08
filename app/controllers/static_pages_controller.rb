class StaticPagesController < ApplicationController
  def home
  	@student = current_club.students.build if logged_in?
  	@total_prospects = current_club.students.includes(:payment_plan).where(payment_plans: {name: 'Prospect'}).count if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end

end
