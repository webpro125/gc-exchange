class Metric < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true
  store_accessor :params

  scope :logins, -> { where(metric_type: LOGIN) }
  scope :searches, -> { where(metric_type: SEARCH) }
  scope :consultants, -> { where(loggable_type: 'Consultant') }
  scope :users, -> { where(loggable_type: 'User') }

  METRIC_TYPES = [LOGIN=:login, SEARCH=:search]

  def self.log_login(user)
    metric = Metric.new metric_type: LOGIN
    metric.loggable = user
    metric.save
  end

  def self.log_search(user, search)
    metric = Metric.new metric_type: SEARCH
    metric.loggable = user
    metric.params = search
    metric.save
  end
end
