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
          if s.created_at.to_date <= to_date.to_date
            if s.active == false and s.updated_at.to_date < from_date.to_date
              @average_deactived_student = @average_deactived_student + 1
            else
              @average_active_student = @average_active_student + 1
            end
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
    else
      if params["show_all"] == "true"
        @activities = club.activities.order("#{sort_column} #{sort_direction}")
      else
        @activities = club.activities.where(active: true).order("#{sort_column} #{sort_direction}")
      end
      @activities.each do |activity|
        @students = activity.students.distinct
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
          @average_membership_length = (@accumulated_memberships_in_days.to_i / @students.count).to_i
        else
          @average_membership_length = 0
        end

        # Average no. of students per session
        @total_attendances = activity.attendances.count
        @total_sessions = activity.attendances.count("DISTINCT(attended_on, timeslot_id)")
        if @total_attendances.nonzero? && @total_sessions.nonzero?
        	@average_attendance = (@total_attendances.to_f / @total_sessions.to_f).round(2)
        else
        	@average_attendance = 0
        end

        # Total active students
        @average_active_student = activity.students.where(active: true).count

        # Total deactivated students
        @average_deactived_student = activity.students.where(active: false).count

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
    end
    @total_entries = metrics.count
    metrics
    if params[:sSearch].present?
      if params["show_all"] == "true"
        @activities = club.activities.order("#{sort_column} #{sort_direction}")
      else
        @activities = club.activities.where(active: true).order("#{sort_column} #{sort_direction}")
      end
      @activities.each do |activity|
        @students = activity.students.distinct
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
          @average_membership_length = (@accumulated_memberships_in_days.to_i / @students.count).to_i
        else
          @average_membership_length = 0
        end

        # Average no. of students per session
        @total_attendances = activity.attendances.count
        @total_sessions = activity.attendances.count("DISTINCT(attended_on, timeslot_id)")
        if @total_attendances.nonzero? && @total_sessions.nonzero?
        	@average_attendance = (@total_attendances.to_f / @total_sessions.to_f).round(2)
        else
        	@average_attendance = 0
        end

        # Total active students
        @average_active_student = activity.students.where(active: true).count

        # Total deactivated students
        @average_deactived_student = activity.students.where(active: false).count

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
    end
    if params[:sSearch_0].present?
      metrics = []
      if params["show_all"] == "true"
        @activities = club.activities.where(name: params[:sSearch_0]).order("#{sort_column} #{sort_direction}")
      else
        @activities = club.activities.where(name: params[:sSearch_0],active: true).order("#{sort_column} #{sort_direction}")
      end
      @activities.each do |activity|
        @students = activity.students.distinct
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
          @average_membership_length = (@accumulated_memberships_in_days.to_i / @students.count).to_i
        else
          @average_membership_length = 0
        end

        # Average no. of students per session
        @total_attendances = activity.attendances.count
        @total_sessions = activity.attendances.count("DISTINCT(attended_on, timeslot_id)")
        if @total_attendances.nonzero? && @total_sessions.nonzero?
        	@average_attendance = (@total_attendances.to_f / @total_sessions.to_f).round(2)
        else
        	@average_attendance = 0
        end

        # Total active students
        @average_active_student = activity.students.where(active: true).count

        # Total deactivated students
        @average_deactived_student = activity.students.where(active: false).count

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
