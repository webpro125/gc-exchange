class WorkLocationAddress < ActiveRecord::Base
  belongs_to :project
  # validates  :address1, :address2, length: { in: 3..512 }, allow_blank: true
  # validates_presence_of :address1, :address2, :city, :st, :zip_code,
  #             :if => lambda { self.project.consultant_location.present? && self.project.consultant_location != 'Remote'}
end
