module Admin::ConsultantHelper
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
end
