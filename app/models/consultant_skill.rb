class ConsultantSkill < ActiveRecord::Base
  belongs_to :consultant
  belongs_to :skill

  validates :skill, presence: true
  validates :consultant, presence: true
end
