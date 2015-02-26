class SharedContact < ActiveRecord::Base
  belongs_to :user
  belongs_to :consultant

  validates :user, presence: true, uniqueness: { scope: :consultant }
  validates :consultant, presence: true
  validates :allowed, presence: true
end
