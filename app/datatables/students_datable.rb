class AttendanceDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Attendance.where(student_id: params[:student_id]).count,
      iTotalDisplayRecords: attendance.total_entries,
      aaData: data
    }
  end

private

  def data
    attendance.map do |atten|
      [
        ERB::Util.h(atten.activity.name),
        ERB::Util.h(atten.find_rank),
        ERB::Util.h(atten.timeslot.time_start.strftime("%I:%M%P") + " - " + atten.timeslot.time_end.strftime("%I:%M%P")),
        ERB::Util.h(Date::DAYNAMES[atten.timeslot.day]),
        ERB::Util.h(atten.attended_on.strftime('%d/%m/%y'))
      ]
    end
  end

  def attendance
    @attendance ||= fetch_attendance
  end

  def fetch_attendance
    if params[:from_date].present? && params[:to_date].present?
      from_date = Date.parse(params[:from_date])
      to_date = Date.parse(params[:to_date])
      attendance = Attendance.joins(:activity, :timeslot).where(student_id: params[:student_id],attended_on: from_date..to_date).order("#{sort_column} #{sort_direction}")
    else
      attendance = Attendance.joins(:activity, :timeslot).where(student_id: params[:student_id]).order("#{sort_column} #{sort_direction}")
    end
    attendance = attendance.page(page).per_page(per_page)
    if params[:sSearch].present?
      attendance = Attendance.joins(:activity, :timeslot).where(student_id: params[:student_id]).order("#{sort_column} #{sort_direction}")
    end
    if params[:sSearch_0].present?
      attendance = attendance.where("activities.name = (?)", params[:sSearch_0])
    end
    if params[:sSearch_1].present?
      attendance1 = Attendance.joins(:activity, :timeslot).where(student_id: params[:student_id]).order("#{sort_column} #{sort_direction}")
      attendance1 = attendance1.select{|a|a.find_rank == params[:sSearch_1]}
      attendance_id = attendance1.pluck(:id)
      attendance = attendance.where(id: attendance_id)
    end
    if params[:sSearch_2].present?
      extract_start = params[:sSearch_2].split(//).first(7).join
      extract_end = params[:sSearch_2].split(//).last(7).join
      start_time = extract_start.to_time.strftime('%H:%M:%S')
      end_time = extract_end.to_time.strftime('%H:%M:%S')
      attendance = attendance.where("timeslots.time_start = (?) AND timeslots.time_end = (?)", start_time,end_time)
    end
    if params[:sSearch_3].present?
      timeslot_day = DateTime.parse(params[:sSearch_3]).wday
      attendance = attendance.where("timeslots.day = (?)", timeslot_day)
    end
    if params[:sSearch_4].present?
      attenance_on = DateTime.strptime(params[:sSearch_4].gsub(/\\/, ""), '%d/%m/%y')
      attendance = attendance.where("attended_on = (?)", attenance_on)
    end
    attendance
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[activities.name timeslots.time_start timeslots.time_end timeslots.day attended_on]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end