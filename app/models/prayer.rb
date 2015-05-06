class Prayer < ActiveRecord::Base
  validates :title, :prayerdate, :prayer,  presence: true

  has_many :volunteersheets, dependent: :destroy
  belongs_to :user
  
      scope :filter_by_date, lambda { |from,to|
    where("prayerdate >= ? and prayerdate <= ?", from, to ) 
  }
        scope :filter_by_single_date, lambda { |prayer_date|
    where("prayerdate = ?" , prayer_date ) 
  }

      scope :filter_by_single_id, lambda { |iD|
    where(" id = ?" , iD ) 
  }
 

    def self.search(params = {})
    prayers =  Prayer.all

    prayers = prayers.filter_by_date(params[:date_from], params[:date_to]) if (params.has_key?(:date_from) & params.has_key?(:date_to))
    prayers = prayers.filter_by_single_date(params[:prayer_date]) if params[:prayer_date]
    prayers = prayers.filter_by_single_id(params[:prayer_id]) if params[:prayer_id]

    prayers
  end
end
