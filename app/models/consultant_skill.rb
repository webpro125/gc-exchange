class ConsultantSkill < ActiveRecord::Base
  belongs_to :consultant
  belongs_to :skill

  validates :skill, presence: true
  validates :consultant, presence: true
  validates :skill, presence: true, uniqueness: { scope: :consultant }
end
