class ProjectHistory < ActiveRecord::Base
  include Indexable

  belongs_to :position
  belongs_to :consultant
  belongs_to :customer_name
  belongs_to :project_type
  has_many :project_history_positions, dependent: :destroy, inverse_of: :project_history
  has_many :positions, through: :project_history_positions

  def destroy
    return if @_destroy_callback_already_called
    @_destroy_callback_already_called = true
    run_callbacks(:destroy) { super }
    ensure
      @_destroy_callback_already_called = false
  end
end
