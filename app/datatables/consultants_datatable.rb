class ConsultantsDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Consultant.count,
      iTotalDisplayRecords: consultants.total_entries,
      aaData: data
    }
  end

  private

  def data
    consultants.map do |consultant|
      [
        link_to(consultant.first_name, consultant),
        consultant.email,
        consultant.approved_status.label
      ]
    end
  end

  def consultants
    @consultants ||= fetch_consultants
  end

  def fetch_consultants
    consultants = Consultant.order("#{sort_column} #{sort_direction}")
    consultants = consultants.page(page).per_page(per_page)
    if params[:sSearch].present?
      consultants = consultants.where('first_name like :search', search: '%#{params[:sSearch]}%')
    end
    consultants
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w(first_name)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
