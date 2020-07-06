class KeyStage < ApplicationRecord
  include Publishable

  has_many :year_groups, dependent: :restrict_with_exception

  has_one_attached :teacher_guide

  validates :description, :level, presence: true
  validates :ages, :level, uniqueness: true
  validates :ages, format: { with: /\A^[0-9]+(-[0-9]+)$\z/,
                             multiline: true,
                             message: 'Please use the following format: 3-5' }

  def short_title
    "KS#{level}"
  end

  def title
    "Key Stage #{level}"
  end
end
