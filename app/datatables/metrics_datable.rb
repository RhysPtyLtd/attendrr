class MetricsDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: data.count,
      iTotalDisplayRecords: @total_entries,
      aaData: data
    }
  end

private

  def data
    metrics.map do |metric|
    [
      ERB::Util.h(metric[0]),
      ERB::Util.h(metric[1]),
      ERB::Util.h(metric[2]),
      ERB::Util.h(metric[3]),
      ERB::Util.h(metric[4]),
      ERB::Util.h(metric[5]),
      ERB::Util.h(metric[6])
    ]
    end
  end

  def metrics
    @metrics ||= fetch_metrics
  end

  def fetch_metrics
    metrics = []
    @total_entries = 0
    club = Club.find_by(id: params[:user_id])
    if params[:from_date].present? && params[:to_date].present?
      from_date = Date.parse(params[:from_date])
      to_date = (Date.parse(params[:to_date])+ 1.days)
    else
      from_date = club.created_at.to_date
      to_date = Date.today + 1.days
    end

      if params["show_all"] == "true"
        @activities = club.activities.where("created_at < ?",to_date).order("#{sort_column} #{sort_direction}")
      else
        @activities = club.activities.where("active = true and created_at < ?",to_date).order("#{sort_column} #{sort_direction}")
      end
      @activities.each do |activity|
        # Average length of membership (days)
        @students = activity.students
        @accumulated_memberships_in_days = 0
        @students.each do |s|
          if s.active?
            n = (Date.today - s.created_at.to_date).to_i
            @accumulated_memberships_in_days += n
          else
            n = (s.updated_at.to_date - s.created_at.to_date).to_i
            @accumulated_memberships_in_days += n
          end
        end
        if @accumulated_memberships_in_days.nonzero? && @students.count.nonzero?
          @average_membership_length = @accumulated_memberships_in_days / @students.count
        else
          @average_membership_length = 0
        end

        # Average no. of students per session
        @total_attendances = activity.attendances.where(attended_on: from_date..to_date).count
        @total_sessions = activity.attendances.where(attended_on: from_date..to_date).count("DISTINCT(attended_on, timeslot_id)")
        if @total_attendances.nonzero? && @total_sessions.nonzero?
        	@average_attendance = (@total_attendances.to_f / @total_sessions.to_f).round(2)
        else
        	@average_attendance = 0
        end

        # Total active students
        # Total deactivated students
        @average_active_student = 0
        @average_deactived_student = 0
        @students = activity.students
        @students.each do |s|
          # Created in period
        	if (from_date..to_date).cover?(s.created_at)
        		@average_active_student += 1
        	# Deactivated in period
          elsif (from_date..to_date).cover?(s.updated_at)
        		@average_active_student += 1
        	# Created before period but still active
          elsif (s.created_at <= from_date) && (s.active == true)
        		@average_active_student += 1
        	# Created before period but deactivated
          elsif (s.created_at <= from_date) && (s.active == false) && (s.updated_at >= from_date)
        		@average_active_student += 1
        	end

        	if (s.active == false) && ((from_date..to_date).cover?(s.updated_at))
        		@average_deactived_student += 1
        	end
        end

        # Retention rate
        if @average_active_student.nonzero?
          @retention_rate = (((@average_active_student.to_f - @average_deactived_student.to_f) / @average_active_student.to_f)*100).to_f.round(2)
        else
          @retention_rate = 0
        end

        metric = []
        metric << ((activity.active)?"#{activity.name}" : "#{activity.name}*")
        metric << @average_attendance.to_i
        metric << @average_membership_length.to_i
        metric << @average_active_student.to_i
        metric << @average_deactived_student.to_i
        metric << "#{@retention_rate}%"
        metric << @average_membership_length.to_i
        metrics << metric
    end
    @total_entries = metrics.count
    metrics
  end

  def sort_column
    columns = %w[activities.name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
