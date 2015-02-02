class ContactRequest < ActiveRecord::Base
  belongs_to :consultant
  belongs_to :user

  validates :consultant, presence: true
  validates :user, presence: true
end
