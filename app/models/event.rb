class Event < ActiveRecord::Base
  validates :title, :eventdate, :eventstart, :eventend, presence: true
      scope :filter_by_date, lambda { |from,to|
    where("eventdate >= ? and eventdate <= ?", from, to ) 
  }
        scope :filter_by_single_date, lambda { |event_date|
    where("eventdate = ?" , event_date ) 
  }
          scope :filter_by_single_id, lambda { |iD|
    where("id = ?" , iD ) 
  }

    def self.search(params = {})
    events =  Event.all

    events = events.filter_by_date(params[:date_from], params[:date_to]) if (params.has_key?(:date_from) & params.has_key?(:date_to))
    events = events.filter_by_single_date(params[:event_date]) if params[:event_date]
    events = events.filter_by_single_id(params[:event_id]) if params[:event_id]
    events
  end
end
