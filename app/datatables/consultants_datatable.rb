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
                         download_resume_path(consultant), target: '_blank') {})
        .push(link_to_if(policy(consultant).contract?,
                         'Download Contract',
                         contract_consultant_path(consultant), target: '_blank') {})
        .push(*project_history_fields(consultant.project_histories[0]))
        .push(*project_history_fields(consultant.project_histories[1]))
        .push(*project_history_fields(consultant.project_histories[2]))
    end
  end

  def consultant_fields(consultant)
    [
      consultant.id,
      link_to(consultant.user.first_name, consultant, target: '_blank'),
      link_to(consultant.user.last_name, consultant, target: '_blank'),
      consultant.phones.size > 0 ? consultant.phones.first.number_with_ext : '',
      mail_to(consultant.user.email),
      consultant.approved_status.label,
      consultant.created_at.to_s(:long),
      consultant.date_pending_approval ? consultant.date_pending_approval.to_s(:long) : nil,
      consultant.date_approved ? consultant.date_approved.to_s(:long) : nil,
      consultant.approval_number,
      consultant.date_on_hold ? consultant.date_on_hold.to_s(:long) : nil,
      consultant.date_rejected ? consultant.date_rejected.to_s(:long) : nil,
      consultant.user.last_sign_in_at ? consultant.user.last_sign_in_at.to_s(:long) : nil,
      consultant.updated_at.to_s(:long),
      consultant.user.sign_in_count,
      consultant.contract_effective_date,
      consultant.contract_version
    ]
  end

  def project_history_fields(history)
    if history.present?
      [
        project_positions(history.positions.pluck(:label)),
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

  def project_positions(positions)
    if positions.size > 3
      first_3 = positions.pop(3).map{|p| "<li> #{p} </li>"}.join
      remaining = positions.map{|p| "<li> #{p} </li>"}.join
      "<span>#{first_3}</span><div class='remaining-positions'>#{remaining}</div><small><a href='#' class='consultant-positions'>More</a></small>"
    else
      positions.map{|p| "<li> #{p} </li>"}.join
    end
  end

  def consultants
    @consultants ||= fetch_consultants
  end

  def fetch_consultants
    result = Consultant.joins(:user).where(wizard_step: Wicked::FINISH_STEP).order("#{sort_column} #{sort_direction}")
                       .page(page)
                       .per(per)

    if params[:search][:value].present?
      where_text = 'last_name ILIKE :search OR email ILIKE :search OR first_name ILIKE :search'
      result = result.where(
                            where_text,
                            search: "%#{params[:search][:value]}%"
                           )
    end

    result
  end

  def page
    params[:start].to_i / per + 1
  end

  def per
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w(id users.first_name users.last_name phone users.email approved_status_id created_at
                 date_pending_approval date_approved approval_number date_on_hold date_rejected last_sign_in_at
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
