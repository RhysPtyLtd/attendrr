class AttendanceDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    if params[:student_id].present?
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: attendance.count,
        iTotalDisplayRecords: params[:iDisplayLength] == "-1" ? attendance.count : attendance.total_entries,
        aaData: data
      } if params[:student_id].present?
    else
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: attendance.count,
        iTotalDisplayRecords: params[:iDisplayLength] == "-1" ? attendance.count : attendance.total_entries,
        aaData: data
      }
    end
  end

private

  def data
    attendance.map do |atten|
      [
        if params[:student_id].present?
          ERB::Util.h(atten.activity.name)
        else
          ERB::Util.h(atten.student.first_name + " " + atten.student.last_name)
        end,
        if atten.rank.active?
          ERB::Util.h(atten.rank.name)
        else
          ERB::Util.h('Rank missing')
        end,
        ERB::Util.h(atten.timeslot.time_start.strftime("%H:%M:%S %P") + " - " + atten.timeslot.time_end.strftime("%H:%M:%S %P")),
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

      attendance = Attendance.joins(:activity, :timeslot, :rank).where(student_id: params[:student_id], attended_on: from_date..to_date).order("#{sort_column} #{sort_direction}") if params[:student_id].present?

      attendance = Attendance.joins(:student, :timeslot, :rank).where(activity_id: params[:activity_id], attended_on: from_date..to_date).order("#{sort_column} #{sort_direction}") if params[:activity_id].present?
    else
      attendance = Attendance.joins(:activity, :timeslot, :rank).where(student_id: params[:student_id]).order("#{sort_column} #{sort_direction}") if params[:student_id].present?

      attendance = Attendance.joins(:student, :timeslot, :rank).where(activity_id: params[:activity_id]).order("#{sort_column} #{sort_direction}") if params[:activity_id].present?
    end
    attendance = if params[:iDisplayLength] == "-1"
        attendance.all
      else
        attendance.page(page).per_page(per_page)
      end
    if params[:sSearch].present?
      attendance = Attendance.joins(:activity, :timeslot, :rank).where(student_id: params[:student_id]).order("#{sort_column} #{sort_direction}") if params[:student_id].present?

      attendance = Attendance.joins(:student, :timeslot, :rank).where(activity_id: params[:activity_id]).order("#{sort_column} #{sort_direction}") if params[:activity_id].present?
    end
    if params[:sSearch_0].present?
      attendance = attendance.where("lower(activities.name) LIKE lower(:q)",q: "%#{params[:sSearch_0]}%") if params[:student_id].present?
      attendance = attendance.where("lower(students.first_name) LIKE lower(:q) OR lower(students.last_name) LIKE lower(:q)", q: "%#{params[:sSearch_0].split.join('%')}%") if params[:activity_id].present?
    end
    if params[:sSearch_1].present?
      attendance = attendance.where("ranks.name = (?)", params[:sSearch_1])
    end
    if params[:sSearch_2].present?
      extract_start = params[:sSearch_2].gsub(/[\\"]/,"").split(' - ')[0]
      extract_end = params[:sSearch_2].gsub(/[\\"]/,"").split(' - ')[1]
      attendance = attendance.where("(timeslots.time_start::time = :start_time) AND (timeslots.time_end::time = :end_time)",start_time: extract_start.split(' ')[0],end_time:   extract_end.split(' ')[0])
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
    columns = %w[activities.name timeslots.time_start timeslots.time_end timeslots.day attended_on] if params[:student_id].present?

    columns = %w[students.first_name timeslots.time_start timeslots.time_end timeslots.day attended_on] if params[:activity_id].present?

    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
