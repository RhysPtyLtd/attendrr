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
        ERB::Util.h(atten.timeslot.time_start.strftime("%I:%M%P")),
        ERB::Util.h(atten.timeslot.time_end.strftime("%I:%M%P")),
        ERB::Util.h(atten.attended_on.strftime('%d/%m/%y'))
      ]
    end
  end

  def attendance
    @attendance ||= fetch_attendance
  end

  def fetch_attendance
    attendance = Attendance.joins(:activity, :timeslot).where(student_id: params[:student_id]).order("#{sort_column} #{sort_direction}")
    attendance = attendance.page(page).per_page(per_page)
    if params[:sSearch].present?
      # attendance = attendance.where("attended_on like :search", search: "%#{params[:sSearch]}%")
      attendance = Attendance.joins(:activity, :timeslot).where(student_id: params[:student_id]).order("#{sort_column} #{sort_direction}")
    end
    if params[:sSearch_1].present?
      start_time = params[:sSearch_1].to_time.strftime('%H:%M:%S')
      attendance = attendance.where("timeslots.time_start = (?)", start_time)
    end
    if params[:sSearch_2].present?
      end_time = params[:sSearch_2].to_time.strftime('%H:%M:%S')
      attendance = attendance.where("timeslots.time_end = (?)", end_time)
    end
    if params[:sSearch_3].present?
      attenance_on = DateTime.strptime(params[:sSearch_3].gsub(/\\/, ""), '%d/%m/%y')
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
    columns = %w[activities.name timeslots.time_start timeslots.time_end attended_on]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end