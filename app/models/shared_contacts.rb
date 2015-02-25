class SharedContacts < ActiveRecord::Base
  belongs_to :user
  belongs_to :consultant

  validates :user_id, presence: true
  validates :consultant_id, presence: true
  validates :allowed, presence: true
end
