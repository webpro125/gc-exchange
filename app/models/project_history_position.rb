class ProjectHistoryPosition < ActiveRecord::Base
  belongs_to :project_history, inverse_of: :project_history_positions
  belongs_to :position

  validates :position, presence: true
  validates :project_history, presence: true, uniqueness: { scope: :position }

  def destroy
    return if @_destroy_callback_already_called
    @_destroy_callback_already_called = true
    run_callbacks(:destroy) { super }
    ensure
      @_destroy_callback_already_called = false
  end
end
