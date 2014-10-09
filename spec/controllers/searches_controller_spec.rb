require 'spec_helper'

describe SearchesController do
  it do
    should permit(search: [:clearance_active, :distance, :address, position_ids: [],
                           clearance_level_ids: [], customer_name_ids: [],
                           discipline_ids: []]).for(:create)
  end
end
