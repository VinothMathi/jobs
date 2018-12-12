class Event < ApplicationRecord
  has_and_belongs_to_many :schedules
  scope :active, ->{where(status: 'active')}

  def active?
    self.status == 'active'
  end

  def toggle_status
    if self.active?
      self.status = 'inactive'
    else
      self.status = 'active'
    end
    self.save
  end
end