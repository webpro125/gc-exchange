class Education < ActiveRecord::Base
  belongs_to :consultant
  belongs_to :degree

  validates :consultant, presence: true
  validates :degree, presence: true
  validates :field_of_study, presence: true, length: { in: 2..256 }
  validates :school, presence: true, length: { in: 2..256 }

  attr_accessor :_destroy
end
