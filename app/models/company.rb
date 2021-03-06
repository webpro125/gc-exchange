class Company < ActiveRecord::Base
  GLOBAL_CONSULTANT_EXCHANGE = 'Global Consultant Exchange'
  GCES_FEE = 10

  belongs_to :owner, class_name: 'User', inverse_of: :owned_company, dependent: :delete
  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :owner

  validates :company_name, length: { in: 2..512 }, presence: true
  validates :owner, presence: true
end
