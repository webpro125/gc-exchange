module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    def mapping
      indexes :address, type: 'geo_point'
    end

    def search(query)
    end

    # Customize the JSON serialization for Elasticsearch
    def as_indexed_json
      as_json(
        methods: [:full_name],
        only: [:full_name, :last_sign_in_at],
        include: {
          skills: {},
          address: {
            methods: [:lat, :lon],
            only: [:lat, :lon]
          },
          project_histories: {
            methods: [:position_name],
            only: [:description, :start_date, :end_date, :position_name, :client_company],
            include: [:disciplines, project_history_positions: {
              only: [:percentage, :position_id],
              include: :position
            }]
          },
          military: {
            only: [:branch, :clearance_status, :clearance_level]
          }
        }
      )
    end
  end
end
