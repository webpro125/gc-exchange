module BusinessUnitRolesHelper
  def get_unit_name unit_role
    if unit_role.selection_authority
      'Selection Authority'
    elsif unit_role.approval_authority
      'Approval Authority'
    elsif @unit_role.requisition_authority
      'Requisition Authority'
    end
  end
end
