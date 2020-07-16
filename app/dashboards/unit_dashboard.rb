require 'administrate/base_dashboard'

class UnitDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    lessons: Field::HasMany,
    year_group: Field::BelongsTo,
    unit_guide: Field::ActiveStorage.with_options(
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_unit_guide, { attachment_id: attachment.id,
                                   unit_id: resource.id }]
      end
    ),
    learning_graphs: Field::ActiveStorage.with_options(
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_learning_graphs, { attachment_id: attachment.id,
                                        unit_id: resource.id }]
      end
    ),
    rubrics: Field::ActiveStorage.with_options(
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_rubrics, { attachment_id: attachment.id,
                                unit_id: resource.id }]
      end
    ),
    summative_assessments: Field::ActiveStorage.with_options(
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_summative_assessments, { attachment_id: attachment.id,
                                              unit_id: resource.id }]
      end
    ),
    summative_answers: Field::ActiveStorage.with_options(
      destroy_url: proc do |_namespace, resource, attachment|
        [:admin_unit_summative_answers, { attachment_id: attachment.id,
                                          unit_id: resource.id }]
      end
    ),
    slug: Field::String,
    id: Field::String.with_options(searchable: false),
    title: Field::String,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    title
    description
    year_group
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    slug
    lessons
    year_group
    unit_guide
    id
    title
    description
    learning_graphs
    rubrics
    summative_assessments
    summative_answers
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    title
    description
    unit_guide
    lessons
    year_group
    learning_graphs
    rubrics
    summative_assessments
    summative_answers
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how units are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(unit)
    unit.title
  end

  def permitted_attributes
    super + [learning_graphs: [],
             rubrics: [],
             summative_assessments: [],
             summative_answers: []]
  end
end
