class ConsultantsDatatable
  delegate :params, :h, :link_to, :link_to_if, :mail_to, :policy,
           :contract_consultant_path, :download_resume_path, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(_options = {})
    {
      draw:            params[:draw],
      sEcho:           params[:sEcho].to_i,
      recordsTotal:    Consultant.count,
      recordsFiltered: consultants.total_count,
      data:            data
    }
  end

  private

  def data
    consultants.map do |consultant|
      consultant_fields(consultant)
        .push(number_to_currency(consultant.rate))
        .push(link_to_if(consultant.resume.present?,
                         'Download Resume',
                         download_resume_path(consultant)) {})
        .push(link_to_if(policy(consultant).contract?,
                         'Download Contract',
                         contract_consultant_path(consultant)) {})
        .push(*project_history_fields(consultant.project_histories[0]))
        .push(*project_history_fields(consultant.project_histories[1]))
        .push(*project_history_fields(consultant.project_histories[2]))
    end
  end

  def consultant_fields(consultant)
    [
      link_to(consultant.first_name, consultant),
      link_to(consultant.last_name, consultant),
      consultant.phones.size > 0 ? consultant.phones.first.number : '',
      mail_to(consultant.email),
      consultant.approved_status.label,
      consultant.created_at.to_s(:long),
      consultant.date_pending_approval ? consultant.date_pending_approval.to_s(:long) : nil,
      consultant.date_approved ? consultant.date_approved.to_s(:long) : nil,
      consultant.date_on_hold ? consultant.date_on_hold.to_s(:long) : nil,
      consultant.date_rejected ? consultant.date_rejected.to_s(:long) : nil,
      consultant.last_sign_in_at ? consultant.last_sign_in_at.to_s(:long) : nil,
      consultant.updated_at.to_s(:long),
      consultant.sign_in_count
    ]
  end

  def project_history_fields(history)
    if history.present?
      [
        history.positions.pluck(:label).join(', '),
        history.client_poc_name,
        history.client_poc_email,
        history.phone.try(:number)
      ]
    else
      [
        '', '', '', ''
      ]
    end
  end

  def consultants
    @consultants ||= fetch_consultants
  end

  def fetch_consultants
    c = Consultant.order("#{sort_column} #{sort_direction}").joins(:project_histories, :positions)
    c = c.page(page).per(per)
    if params[:search][:value].present?
      c = c.where('last_name like :search or email like :search or first_name like :search',
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
    columns = %w(first_name last_name id email approved_status_id created_at
                 date_pending_approval date_approved date_on_hold date_rejected last_sign_in_at
                 updated_at sign_in_count rate resume contract_effective_date positions.label
                 project_histories.client_poc_name project_histories.client_poc_email id
                 positions.label project_histories.client_poc_name
                 project_histories.client_poc_email id positions.label
                 project_histories.client_poc_name project_histories.client_poc_email
                 positions.label)

    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
  end
end