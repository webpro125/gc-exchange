class Company < ActiveRecord::Base
  GLOBAL_CONSULTANT_EXCHANGE = 'Global Consultant Exchange'

  belongs_to :owner, class_name: 'User', inverse_of: :owned_company, dependent: :delete
  has_many :users, dependent: :destroy
  has_many :contact_requests, dependent: :destroy

  accepts_nested_attributes_for :owner

  validates :company_name, length: { in: 2..512 }, presence: true
  validates :owner, presence: true
end
