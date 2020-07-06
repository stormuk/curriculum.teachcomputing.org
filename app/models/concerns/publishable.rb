module Publishable
  extend ActiveSupport::Concern

  included do
    belongs_to :state, dependent: :destroy

    after_initialize :create_state

    scope :published, -> { joins(:state).where('states.state = ?', State.states[:published]) }

    delegate :published?, :published!, :unpublished!, to: :state
  end

  def method_missing(method_name, *args, &block)
    if method_name.to_s =~ /published_(.*)/
      model_name = Regexp.last_match(1).to_sym
      self.class.send :define_method, method_name do
        send(model_name).published
      end
      send(method_name)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('published_') || super
  end

  private

    def create_state
      self.state = State.new unless state.present?
    end
end
