class Company < ActiveRecord::Base
  has_many :user_companies, dependent: :destroy
  has_many :users, through: :user_companies
  belongs_to :company_owner, class_name: 'User'

  validates :company_name, length: { in: 2..128 }, presence: true
  validates :company_owner, presence: true
end
