module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    index_name [Rails.env, model_name.collection.gsub(%r{/}, '-')].join('_')

    mapping do
      indexes :resume_attachment, type: 'attachment'
      indexes :address, type: :geo_point
      indexes :military do
        indexes :clearance_level_id, null_value: 0
      end
      indexes :project_histories do
        indexes :customer_name do
          indexes :id
          indexes :code
          indexes :label
        end
      end
    end

    def resume_attachment
      Base64.encode64(open(resume_fullpath) { |file| file.read })
    end

    def resume_fullpath
      resume.cache_stored_file! if resume.cached?.blank?
      resume.path
    end

    # Customize the JSON serialization for Elasticsearch
    def as_indexed_json(options = {})
      as_json(
        {
          methods: [:full_name, :skills_list, :abstract, :resume_attachment],
          only: [:full_name, :last_sign_in_at, :skills_list, :resume_attachment],
          include: {
            address: {
              methods: [:lat, :lon],
              only: [:lat, :lon]
            },
            project_histories: project_histories_as_json,
            military: military_as_json,
            certifications: {}
          }
        }.merge(options)
      )
    end
  end

  private

  def project_histories_as_json
    {
      only: [:description, :start_date, :end_date, :client_company],
      include: [:customer_name, :project_type, project_history_positions: {
        only: [:percentage],
        include: :position
      }]
    }
  end

  def military_as_json
    {
      only: [:branch, :clearance_active, :clearance_level_id]
    }
  end
end
