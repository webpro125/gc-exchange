class Company < ActiveRecord::Base
  has_many :users, inverse_of: :company, autosave: true
  belongs_to :company_owner, class_name: 'User', inverse_of: :owned_company

  validates :company_name, length: { in: 2..128 }, presence: true
  validates :company_owner, presence: true
end
