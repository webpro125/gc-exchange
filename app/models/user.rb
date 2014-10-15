class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company, inverse_of: :users, autosave: true
  has_one :owned_company, class_name: 'Company', foreign_key: :company_owner_id,
          inverse_of: :company_owner, autosave: true

  before_create :skip_confirmation_in_staging, if: -> { Rails.env.staging? }
  before_validation :assign_company

  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_DASHES,
                      message: 'only allows letters' }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Words::AND_SPECIAL,
                      message: 'only allows letters and numbers' }
  validates :email, presence: true

  private

  def skip_confirmation_in_staging
    skip_confirmation!
  end

  def assign_company
    if owned_company.present?
      self.company = self.owned_company
    end
    # company = Company.find_or_create_by(:id)
    # companies << company
  end
end
