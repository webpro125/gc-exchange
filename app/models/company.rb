class Company < ActiveRecord::Base
  has_many :users
  belongs_to :owner, class_name: 'User', inverse_of: :owned_company

  validates :company_name, length: { in: 2..128 }, presence: true
  validates :owner, presence: true
end
