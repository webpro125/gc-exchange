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
    cumulative_logins = Metric.consultants.logins.group_by_day(:created_at).count
    cumulative_uniq_logins = Metric.consultants.logins.select("DISTINCT concat(loggable_type, loggable_id)").group_by_day(:created_at).count

    {
      categories: user_count.keys,
      user_count: user_count.values,
      profiles_approved: profiles_approved.values,
      profiles_pending: profiles_pending.values,
      total_logins: total_logins.values,
      uniq_logins: uniq_logins.values,
      cumulative_start: cumulative_logins.keys.first,
      cumulative_logins: cumulative_logins.values.cumulative_sum,
      cumulative_uniq_logins: cumulative_uniq_logins.values.cumulative_sum
    }
  end

  def general_user_metrics
    group_options = FILTER_TYPES[@filter]
    user_count = User.group_by_period(
      group_options[:period], :created_at,
      range: @from..@to, format: group_options[:format]
    ).count
    total_logins = Metric.users.logins.group_by_period(
      group_options[:period], :created_at,
      range: @from..@to, format: group_options[:format]
    ).count
    uniq_logins = Metric.users.logins.select("DISTINCT concat(loggable_type, loggable_id)").group_by_period(
      group_options[:period], :created_at,
      range: @from..@to, format: group_options[:format]
    ).count
    cumulative_logins = Metric.users.logins.group_by_day(:created_at).count
    cumulative_uniq_logins = Metric.users.logins.select('DISTINCT concat(loggable_type, loggable_id)').group_by_day(:created_at).count

    {
      categories: user_count.keys,
      user_count: user_count.values,
      total_logins: total_logins.values,
      uniq_logins: uniq_logins.values,
      cumulative_start: cumulative_logins.keys.first,
      cumulative_logins: cumulative_logins.values.cumulative_sum,
      cumulative_uniq_logins: cumulative_uniq_logins.values.cumulative_sum
    }
  end

  def company_metrics
    group_options = FILTER_TYPES[@filter]
    company_count = Company.group_by_period(
      group_options[:period], :created_at,
      range: @from..@to, format: group_options[:format]
    ).count
    total_logins = Metric.companies.logins.group_by_period(
      group_options[:period], :created_at,
      range: @from..@to, format: group_options[:format]
    ).count
    uniq_logins = Metric.companies.logins.select("DISTINCT concat(loggable_type, loggable_id)").group_by_period(
      group_options[:period], :created_at,
      range: @from..@to, format: group_options[:format]
    ).count
    cumulative_logins = Metric.companies.logins.group_by_day(:created_at).count
    cumulative_uniq_logins = Metric.companies.logins.select('DISTINCT concat(loggable_type, loggable_id)').group_by_day(:created_at).count

    {
      categories: company_count.keys,
      company_count: company_count.values,
      total_logins: total_logins.values,
      uniq_logins: uniq_logins.values,
      cumulative_start: cumulative_logins.keys.first,
      cumulative_logins: cumulative_logins.values.cumulative_sum,
      cumulative_uniq_logins: cumulative_uniq_logins.values.cumulative_sum
    }
  end

  def search_metrics
    searches = Metric.searches.where(created_at: @from..@to)
    cumulative_searches = searches.group_by_day(:created_at).count
    keywords = searches.queries.group_by_count.map { |q, count| {text: q, weight: count} }

    positions = searches.positions
    position_labels = Position.where(id: positions).to_a
    positions = positions.group_by_count.map { |q, count| {text: position_labels.detect { |p| p.id == q.to_i }.label, weight: count} }

    areas = searches.areas
    area_labels = ProjectType.where(id: areas).to_a
    areas = areas.group_by_count.map { |q, count| {text: area_labels.detect { |p| p.id == q.to_i }.label, weight: count} }

    departments = searches.departments
    department_labels = CustomerName.where(id: departments).to_a
    departments = departments.group_by_count.map { |q, count| {text: department_labels.detect { |p| p.id == q.to_i }.label, weight: count} }

    certs = searches.certifications
    cert_labels = Certification.where(id: certs).to_a
    certifications = certs.group_by_count.map { |q, count| {text: cert_labels.detect { |p| p.id == q.to_i }.label, weight: count} }

    {
      keywords: keywords,
      positions: positions,
      areas: areas,
      departments: departments,
      certifications: certifications,
      cumulative_searches_start: cumulative_searches.keys.first,
      cumulative_searches: cumulative_searches.values.cumulative_sum
    }
  end

  def public_metrics
    return {valid: false} unless ga_api_available?

    {
      pageviews: GA_API_CLIENT.pageviews(@from, @to),
      avg_session_duration: GA_API_CLIENT.avg_session_duration(@from, @to),
      avg_session_duration_sum: GA_API_CLIENT.avg_session_duration_sum(@from, @to),
      pages_per_session: GA_API_CLIENT.pages_per_session(@from, @to),
      sessions_per_device: GA_API_CLIENT.sessions_per_device(@from, @to),
      sessions_in_bound: GA_API_CLIENT.sessions_in_bound(@from, @to),
      sessions_per_browser: GA_API_CLIENT.sessions_per_browser(@from, @to),
      sessions_per_country: GA_API_CLIENT.sessions_per_country(@from, @to),
      sessions_per_city: GA_API_CLIENT.sessions_per_city(@from, @to),
      valid: true
    }
  end

  private

  def ga_api_available?
    GA_API_CLIENT.valid?
  end
end