class Military < ActiveRecord::Base
  belongs_to :consultant
  belongs_to :clearance_level
  belongs_to :rank

  validates :consultant, presence: true, uniqueness: true
  validates :service_end_date, date: { after: :service_start_date, before: DateTime.now },
            allow_blank: true, if: ->() { service_start_date }
end
