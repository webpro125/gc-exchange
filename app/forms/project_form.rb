require 'reform/form/coercion'

class ProjectForm < Reform::Form
  model :project

  property :consultant_id
  property :proposed_start, type: DateTime
  property :proposed_end, type: DateTime
  properties :travel_authorization, :project_name, :consultant_location, :proposed_rate,
          :rate_approve, :summarize_statement
  property :travel_authorization

  property :sow

  property :work_location_address, populate_if_empty: WorkLocationAddress do
    model :work_location_address
    properties :address1, :address2, :city, :st, :zip_code
    validates  :address1, :address2, length: { in: 3..512 }, allow_blank: true
    # validates_presence_of :address1, :address2, :city, :st, :zip_code
    #   :if => lambda { self.mode.project.consultant_location.present? && self.model.project.consultant_location != 'Remote'}
  end

  validates :consultant_id, presence: true
  validates :travel_authorization, presence: true
  validates :proposed_start, presence: true, date: { on_or_after: DateTime.now }
  validates :proposed_end, presence: true, date: { on_or_after: :proposed_start }
  validates :summarize_statement, length: { in: 2..500 }, allow_blank: true
  validates :consultant_location, :rate_approve, presence: true
  validates :project_name,
            presence:   true,
            length:     { in: 2..128 },
            uniqueness: { case_sensitive: true }
  validates :proposed_rate, allow_blank: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 5000 }

  validate :sow_or_summarize_statement
  validate :consultant_rate

  private

  def sow_or_summarize_statement
    if sow.blank? && summarize_statement.blank?
      errors.add(:summarize_statement, "Specify a Summarize Statement of Work or Upload File, not both")
    end
  end

  def consultant_rate
    if rate_approve == 'false' && proposed_rate.blank?
      errors.add(:proposed_rate, "Can't be blank")
    end
    if (consultant_location == 'On-Site' || consultant_location == 'both') && work_location_address.address1.blank?
      # errors.add(:"work_location_address.address1", "can't blank")
      errors['work_location_address.address1'] << "your colors don't match!"
      errors['work_location_address.address1'].uniq!
    end
  end
end
