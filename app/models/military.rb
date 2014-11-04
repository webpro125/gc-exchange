class Military < ActiveRecord::Base
  include Indexable

  belongs_to :consultant
  belongs_to :clearance_level
  belongs_to :rank
  belongs_to :branch

  validates :consultant, presence: true, uniqueness: true
end
