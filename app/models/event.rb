class Event < ActiveRecord::Base
  validates :title, :date, :start, :end, presence: true
      scope :filter_by_date, lambda { |from,to|
    where("date >= ? and date <= ?", from, to ) 
  }

    def self.search(params = {})
    events =  Event.all

    events = events.filter_by_date(params[:date_from], params[:date_to]) if params[:date_from]&params[:date_to]

    events
  end
end
