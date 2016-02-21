class ReportBuilder
  def initialize(from, to)
    @from = from
    @to = to
  end

  def metrics
    user_count = User.where(created_at: @from..@to).count
    profiles_approved = Consultant.where(date_approved: @from..@to).count
    profiles_pending = Consultant.where(date_pending_approval: @from..@to).count

    {
      new_accounts: user_count,
      approved: profiles_approved,
      pending: profiles_pending
    }
  end
end