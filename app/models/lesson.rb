class Lesson < ApplicationRecord
  include Publishable
  include Rateable
  include Redirectable

  belongs_to :unit
  has_many :aggregate_downloads, as: :downloadable, dependent: :destroy
  has_many :learning_objectives

  has_one_attached :zipped_contents

  validates :title, :description, presence: true
  validates :slug, uniqueness: { scope: [:unit_id] }

  before_create :set_slug

  after_commit :notify_update

  scope :ordered, -> { order(:order) }

  accepts_nested_attributes_for :learning_objectives, allow_destroy: true
  accepts_nested_attributes_for :redirects, allow_destroy: true

  validate :valid_learning_objective_count

  def set_slug
    self.slug = title.parameterize
  end

  def primary?
    unit&.primary?
  end

  def secondary?
    unit&.secondary?
  end

  def valid_learning_objective_count
    return unless learning_objectives.present?
    return unless primary? && learning_objectives.size > 1

    errors.add(:learning_objectives, 'only one learning objective allowed for primary lessons')
  end

  private

    def notify_update
      UpdateNotifier.new([self, unit], { lesson: "#{unit.slug}-#{slug}" }).run
    end
end
