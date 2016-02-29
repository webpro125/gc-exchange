class Admin::ProjectsController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!

  def index
    @projects = Project.order(created_at: :desc)
    @projects_grid = initialize_grid(Project,
                                        order: 'created_at',
                                        order_direction: 'desc',
                                        per_page: 10,
                                        name: 'g1',
                                        enable_export_to_csv: true,
                                        csv_field_separator: ',',
                                        csv_file_name: 'projects'
    )

    export_grid_if_requested('g1' => 'projects_grid') do
      # usual render or redirect code executed if the request is not a CSV export request
    end
  end
end
