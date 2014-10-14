require 'spec_helper'

describe SearchesController do
  it do
    should permit(search: [:distance, :address, position_ids: [], clearance_level_ids: [],
                           customer_name_ids: [], project_type_ids: []]).for(:create)
  end
end
