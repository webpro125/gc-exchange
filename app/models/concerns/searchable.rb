module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    index_name [Rails.env, model_name.collection.gsub(%r{/}, '-')].join('_')

    mapping dynamic: 'strict' do
      indexes :address, type: 'geo_point'
    end

    # Customize the JSON serialization for Elasticsearch
    def as_indexed_json(options = {})
      as_json(
        {
          methods: [:full_name],
          only: [:full_name, :last_sign_in_at],
          include: {
            skills: { only: :code },
            address: {
              methods: [:lat, :lon],
              only: [:lat, :lon]
            },
            project_histories: project_histories_as_json,
            military: military_as_json
          }
        }.merge(options)
      )
    end
  end

  private

  def project_histories_as_json
    {
      methods: [:position_name],
      only: [:description, :start_date, :end_date, :position_name, :client_company],
      include: [:disciplines, project_history_positions: {
        only: [:percentage],
        include: :position
      }]
    }
  end

  def military_as_json
    {
      only: [:branch, :clearance_status, :clearance_level]
    }
  end
end
