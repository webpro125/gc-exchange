require 'spec_helper'

describe SearchesController do
  it do
    should permit(search: [:address, :q, :clearance_level_id, position_ids: [],
                           customer_name_ids: [], project_type_ids: [],
                           certification_ids: []]).for(:new, verb: :get)
  end
end
