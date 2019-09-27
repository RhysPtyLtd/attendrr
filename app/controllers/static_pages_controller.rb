class StaticPagesController < ApplicationController
  def home
  	if logged_in?
      @student = current_club.students.build
  	  @total_prospects = current_club.students.includes(:payment_plan).where(payment_plans: {name: 'Prospect'})
      @active_prospects = @total_prospects.where(active: true)
      @absent_alert = current_club.absent_alert
      @absent_alert_activation_date = Date.today - current_club.absent_alert
      @students = current_club.students.where(active: true)
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
