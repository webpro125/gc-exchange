class ConsultantsDatatable
  delegate :params, :h, :link_to, :link_to_if, :mail_to, :policy,
           :contract_consultant_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(_options = {})
    {
      draw: params[:draw],
      sEcho: params[:sEcho].to_i,
      recordsTotal: Consultant.count,
      recordsFiltered: consultants.total_count,
      data: data
    }
  end

  private

  def data
    consultants.map do |consultant|
      [
        link_to(consultant.first_name + ' ' + consultant.last_name, consultant),
        mail_to(consultant.email, 'Send Mail'),
        consultant.approved_status.label,
        link_to_if(policy(consultant).contract?,
                   'Download Contract',
                   contract_consultant_path(consultant)) {}
      ]
    end
  end

  def consultants
    @consultants ||= fetch_consultants
  end

  def fetch_consultants
    c = Consultant.order("#{sort_column} #{sort_direction}")
    c = c.page(page).per(per)
    if params[:search][:value].present?
      c = c.where('last_name like :search or email like :search',
                  search: "%#{params[:search][:value]}%")
    end
    c
  end

  def page
    params[:start].to_i / per + 1
  end

  def per
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w(last_name email approved_status_id contract_effective_date)
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
  end
end
