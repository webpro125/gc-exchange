class ProjectHistory < ActiveRecord::Base
  belongs_to :position
  belongs_to :consultant
  belongs_to :customer_name
  belongs_to :project_type
  has_many :project_history_disciplines, dependent: :destroy
  has_many :disciplines, through: :project_history_disciplines
  has_many :project_history_positions, dependent: :destroy, inverse_of: :project_history
  has_many :positions, through: :project_history_positions

  accepts_nested_attributes_for :project_history_positions, allow_destroy: true

  validate :percentage_calculation
  validates :start_date, presence: true
  validates :project_type, presence: true
  validates :project_history_positions, length: { in: 1..3 }
  validates :description, length: { in: 3..1_500 }, allow_blank: true
  validates :end_date, date: { after: :start_date, before: DateTime.now },
            allow_blank: true, if: ->() { start_date.present? }
  validates :client_company, length: { in: 3..24 }, presence: true
  validates :client_poc_name, length: { in: 2..24 }, presence: true,
            format: { with: /\A[\w\s\.-]+\z/, message: 'only allows letters and numbers' }
  validates :client_poc_email, length: { in: 3..128 }, presence: true,
            format: { with: Devise.email_regexp, message: 'must be valid email' }

  private

  def percentage_calculation
    # performance issue potentially here  pluck() or sum is better but doesn't get new records
    return if 100 == project_history_positions.reduce(0) { |a, e| a + e.percentage }
    errors.add(:project_history_positions,
               I18n.t('activerecord.errors.models.project_history.attributes' \
                        '.project_history_positions.total'))
  end
end
