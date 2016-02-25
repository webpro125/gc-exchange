class Admin::ConsultantsController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!
  def index
    @consultants_grid = initialize_grid(Consultant,
                                       order: 'created_at',
                                       order_direction: 'desc',
                                       per_page: 10,
                                       name: 'g1',
                                       enable_export_to_csv: true,
                                       csv_field_separator: ',',
                                       csv_file_name: 'consultants'
    )

    export_grid_if_requested('g1' => 'consultants_grid') do
      # usual render or redirect code executed if the request is not a CSV export request
    end
  end
end
