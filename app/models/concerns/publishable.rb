module Publishable
  extend ActiveSupport::Concern

  included do
    belongs_to :state, dependent: :destroy
    scope :published, -> { joins(:state).where('states.state = ?', State.states[:published]) }
  end

  def published?
    state.published?
  end
end
