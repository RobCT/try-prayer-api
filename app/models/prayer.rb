class Event < ActiveRecord::Base
  validates :title, :eventdate, :eventstart, :eventend, presence: true
  validates_with EventendGreaterthanEventstartValidator
  has_many :volunteersheets, dependent: :destroy
  belongs_to :user
  
      scope :filter_by_date, lambda { |from,to|
    where("eventdate >= ? and eventdate <= ?", from, to ) 
  }
        scope :filter_by_single_date, lambda { |event_date|
    where("is_private = false and eventdate = ?" , event_date ) 
  }
        scope :filter_private_by_single_date, lambda { |event_date|
    where("is_private = true and eventdate = ?" , event_date ) 
  }
      scope :filter_by_single_id, lambda { |iD|
    where("is_private = false and id = ?" , iD ) 
  }
          scope :filter_private_by_single_id, lambda { |iD|
    where("is_private = true and id = ?" , iD ) 
  }
          scope :filter_my_events, lambda { |iD|
    where("(is_private = true and id = ?) and (is_private = false)" , iD ) 
  }
          scope :filter_my_events_by_single_date, lambda { |iD, event_date|
    where("(is_private = true and id = ? and eventdate = ? ) or (is_private = false and eventdate = ?)" , iD, event_date, event_date ) 
  }  

    def self.search(params = {})
    events =  Event.all

    events = events.filter_by_date(params[:date_from], params[:date_to]) if (params.has_key?(:date_from) & params.has_key?(:date_to))
    events = events.filter_by_single_date(params[:event_date]) if params[:event_date]
    events = events.filter_by_single_id(params[:event_id]) if params[:event_id]
   # events = events.filter_private_by_single_id(params[:event_id]) if params[:event_id]
   # events = events.filter_private_by_single_date(params[:event_date]) if params[:event_date]
    #events = events.filter_my_events(current_user.id)
    events
  end
end
