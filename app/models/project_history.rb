class ProjectHistory < ActiveRecord::Base
  include Indexable

  belongs_to :position
  belongs_to :consultant
  belongs_to :customer_name
  belongs_to :project_type
  has_many :project_history_positions, dependent: :destroy, inverse_of: :project_history
  has_many :positions, through: :project_history_positions
  has_one :phone, as: :phoneable, dependent: :destroy
end
