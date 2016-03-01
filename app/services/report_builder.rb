class ReportBuilder
  FILTER_TYPES = {
    'day'     => {period: 'hour', format: '%-l %p'},
    'week'    => {period: 'day', format: '%m/%d/%Y'},
    'month'   => {period: 'day', format: '%d'},
    'quarter' => {period: 'week', format: 'Week %W'},
    'year'    => {period: 'month', format: '%b %Y'}
  }

  def initialize(from, to, filter)
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

  def visits
    return {} unless ga_api_available?
    data = GA_API_CLIENT.visits(@from, @to)
  end

  private

  def ga_api_available?
    GA_API_CLIENT.present?
  end
end