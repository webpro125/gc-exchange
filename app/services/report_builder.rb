class ReportBuilder
  FILTER_TYPES = {
    'day'     => {period: 'hour', format: '%-l %p'},
    'week'    => {period: 'day', format: '%m/%d/%Y'},
    'month'   => {period: 'day', format: '%d'},
    'quarter' => {period: 'week', format: 'Week %W'},
    'year'    => {period: 'month', format: '%b %Y'}
  }

  def initialize(from, to, filter = 'day')
    @from = from
    @to = to
    @filter = filter
  end

  def consultant_metrics
    group_options = FILTER_TYPES[@filter]
    user_count = Consultant.group_by_period(
      group_options[:period], :created_at,
      range: @from..@to, format: group_options[:format]
    ).count
    profiles_approved = Consultant.group_by_period(
      group_options[:period], :date_approved,
      range: @from..@to, format: group_options[:format]
    ).count
    profiles_pending = Consultant.group_by_period(
      group_options[:period], :date_pending_approval,
      range: @from..@to, format: group_options[:format]
    ).count
    total_logins = Metric.consultants.logins.group_by_period(
      group_options[:period], :created_at,
      range: @from..@to, format: group_options[:format]
    ).count
    uniq_logins = Metric.consultants.logins.select("DISTINCT concat(loggable_type, loggable_id)").group_by_period(
      group_options[:period], :created_at,
      range: @from..@to, format: group_options[:format]
    ).count

    {
      categories: user_count.keys,
      user_count: user_count.values,
      profiles_approved: profiles_approved.values,
      profiles_pending: profiles_pending.values,
      total_logins: total_logins.values,
      uniq_logins: uniq_logins.values
    }
  end

  def search_metrics
  end

  def visits_metrics
    return {} unless ga_api_available?
    {
      pageviews: GA_API_CLIENT.pageviews(@from, @to),
      avg_session_duration: ApplicationController.helpers.distance_of_time_in_words(GA_API_CLIENT.avg_session_duration(@from, @to)),
      pages_per_session: GA_API_CLIENT.pages_per_session(@from, @to)
    }
  end

  private

  def ga_api_available?
    GA_API_CLIENT.present?
  end
end