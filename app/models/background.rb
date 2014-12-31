class Background < ActiveRecord::Base
  belongs_to :consultant

  validates :consultant, presence: true
  validates :information_is_correct, acceptance: true
end
