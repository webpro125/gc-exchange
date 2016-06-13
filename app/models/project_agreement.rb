class ProjectAgreement < ActiveRecord::Base
  belongs_to :project
  validates :project_name_agreement, :inclusion => {:in => [true, false]}
  validates :project_period_agreement, :consultant_location_agreement,
            :travel_authorization_agreement, :consultant_rate_agreement, :sow_agreement, :inclusion => {:in => [true, false]}
  validates :project_name_reason, :project_period_reason, :consultant_location_reason,
            :travel_authorization_reason, :consultant_rate_reason, :sow_reason,
            length: { in: 2..500 }, allow_blank: true
  validate :reject_reason

  private

  def reject_reason
    if !project_name_agreement && project_name_reason.blank?
      errors.add(:project_name_reason, "can't be blank")
    end
    if !project_period_agreement && project_period_reason.blank?
      errors.add(:project_period_reason, "can't be blank")
    end
    if !consultant_location_agreement && consultant_location_reason.blank?
      errors.add(:consultant_location_reason, "can't be blank")
    end
    if !travel_authorization_agreement && travel_authorization_reason.blank?
      errors.add(:travel_authorization_reason, "can't be blank")
    end
    if !consultant_rate_agreement && consultant_rate_reason.blank?
      errors.add(:consultant_rate_reason, "can't be blank")
    end
    if !sow_agreement && sow_reason.blank?
      errors.add(:sow_reason, "can't be blank")
    end
  end
end
