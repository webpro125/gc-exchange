class Metric < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true
  store_accessor :params

  scope :logins, -> { where(metric_type: LOGIN) }
  scope :searches, -> { where(metric_type: SEARCH) }
  scope :consultants, -> { where(loggable_type: 'Consultant') }
  scope :users, -> { where(loggable_type: 'User') }

  QUERY_METRICS = {
    position_ids: :positions,
    project_type_ids: :areas,
    customer_name_ids: :departments
  }

  scope :queries, -> {
    select("params -> 'q' as results")
      .map(&:results).reject(&:empty?).flatten
  }

  QUERY_METRICS.keys.each do |key|
    scope QUERY_METRICS[key], -> {
      select("params -> '#{key.to_s}' as results")
        .map(&:results).compact
        .map { |data| JSON.parse(data) }
        .reject(&:empty?).flatten
    }
  end

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
