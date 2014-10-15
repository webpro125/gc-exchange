class ConsultantCertification < ActiveRecord::Base
  belongs_to :consultant
  belongs_to :certification

  validates :consultant, presence: true
  validates :certification, presence: true, uniqueness: { scope: :consultant }
end
