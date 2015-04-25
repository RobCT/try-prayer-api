 class EventendGreaterthanEventstartValidator < ActiveModel::Validator
  def validate(record)
    unless record.eventend > record.eventstart
      record.errors[:eventend] << 'Event end must be after event start!'
    end
  end
end