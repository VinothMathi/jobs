class JobsLog < ApplicationRecord
  belongs_to :schedule
  belongs_to :event, optional: true
end