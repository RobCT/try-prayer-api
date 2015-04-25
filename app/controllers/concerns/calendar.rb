module Calendar
  Date::beginning_of_week=:sunday
  Date::DATE_FORMATS[:day_of_week] = '%A'
    def render_calendar_to_json(calendar_params)
      @date=Date.new(calendar_params[:year].to_i,calendar_params[:month].to_i,calendar_params[:day].to_i, )
      calendar = Array.new
      case calendar_params[:type]
      when "month"
        start_date = @date - @date.wday
        end_date = @date.end_of_month + 6 - @date.end_of_month.wday
        (start_date..end_date).each do |dd|
          calendar << {"date"=>dd.to_time(:utc).to_formatted_s(:rfc822), "day_of_week"=>dd.to_formatted_s(:day_of_week),"events"=>Event.filter_by_single_date(dd)}
        end 
        render json: calendar.to_json, status: 200 
      when "week"
        start_date = @date - @date.wday
        end_date = @date.end_of_week + 6 - @date.end_of_week.wday
        (start_date..end_date).each do |dd|
          calendar << {"date"=>dd.to_time(:utc).to_formatted_s(:rfc822), "day_of_week"=>dd.to_formatted_s(:day_of_week),"events"=>Event.filter_by_single_date(dd)}
        end
        render json: calendar.to_json, status: 200 
      when "day"
        calendar << {"date"=>@date.to_time(:utc).to_formatted_s(:rfc822), "day_of_week"=>@date.to_formatted_s(:day_of_week),"events"=>Event.filter_by_single_date(@date)}
        render json: calendar.to_json, status: 200  
      end
  end
  
end