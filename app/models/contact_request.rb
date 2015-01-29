class ContactRequest < ActiveRecord::Base
  belongs_to :consultant
  belongs_to :user

  validates :consultant, presence: true
  validates :user, presence: true
  validates :project_start, date: { on_or_before: DateTime.now }
  validates :project_end, date: { on_or_after: :project_start },
            allow_blank: true, if: ->() { project_start.present? }
  validates :message, presence: true
end
