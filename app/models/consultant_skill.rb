class ConsultantSkill < ActiveRecord::Base
  belongs_to :consultant
  belongs_to :skill

  validates :skill, presence: true
  validates :consultant, presence: true
  validates_uniqueness_of :skill_id, scope: [:consultant_id, :skill_id]
end
