class StaticPagesController < ApplicationController
  def home
  	if logged_in?
      @student = current_club.students.build
  	  @total_prospects = current_club.students.includes(:payment_plan).where(payment_plans: {name: 'Prospect'})
      @prospects = TypeOfStudent.active_prospects(current_club)
      @absent_alert = current_club.absent_alert
      @absent_alert_activation_date = Date.today - current_club.absent_alert
      @students = TypeOfStudent.active_enrolled(current_club)
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
