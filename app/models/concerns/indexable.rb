module Indexable
  extend ActiveSupport::Concern

  included do
    after_commit :update_consultant_index, on: [:create, :update, :destroy]
  end

  private

  def update_consultant_index
    ConsultantIndexer.perform_async(:update, consultant.id) if consultant.approved?
  end
end
