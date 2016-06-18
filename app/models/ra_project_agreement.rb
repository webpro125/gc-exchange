class RaProjectAgreement < ActiveRecord::Base
  enum status: [:accept, :reject]

  belongs_to :project_agreement
  validates :project_name_agreement, :inclusion => {:in => [true, false]}
  validates :project_period_agreement, :consultant_location_agreement,
            :travel_authorization_agreement, :consultant_rate_agreement, :sow_agreement, :inclusion => {:in => [true, false]}
  validates :project_name_reason, :project_period_reason, :consultant_location_reason,
            :travel_authorization_reason, :consultant_rate_reason, :sow_reason,
            length: { in: 2..500 }, allow_blank: true

  validates_presence_of :project_name_reason,
    :if => lambda { !project_name_agreement }
  validates_presence_of :project_period_reason,
                        :if => lambda { !project_period_agreement }
  validates_presence_of :consultant_location_reason,
                        :if => lambda { !consultant_location_agreement }
  validates_presence_of :travel_authorization_reason,
                        :if => lambda { !travel_authorization_agreement }
  validates_presence_of :consultant_rate_reason,
                        :if => lambda { !consultant_rate_agreement }
  validates_presence_of :sow_reason,
                        :if => lambda { !sow_agreement }

  validate :commit_available
  after_create :save_project_status

  def project
    project_agreement.project
  end

  def accept_available?
    project_name_agreement && project_period_agreement && consultant_location_agreement &&
      travel_authorization_agreement && consultant_rate_agreement && sow_agreement
  end

  private

  def commit_available
    if status == 'reject' && accept_available?
      errors.add(:commit, "You cannot reject since you agreed all agreement!")
    end

    if status != 'reject' && !accept_available?
      # flash[:alert] = "You cannot accept since you disagreed all agreements"
      errors.add(:commit, "You cannot accept since you disagreed even one agreements")
    end
  end

  def save_project_status
    if self.status == 'reject'
      self.project.update_attributes(contact_status: 'rejected')
    end
  end
end
