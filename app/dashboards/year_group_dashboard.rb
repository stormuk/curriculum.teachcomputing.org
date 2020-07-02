require "administrate/base_dashboard"

class YearGroupDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    units: Field::HasMany,
    key_stage: Field::BelongsTo,
    id: Field::String.with_options(searchable: false),
    learning_graph: Field::ActiveStorage.with_options(
      destroy_url: proc do |namespace, resource, attachment|
        [:admin_year_group_learning_graph, { attachment_id: attachment.id,
                                             year_group_id: resource.id }]
      end
    ),
    year_number: Field::String,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    year_number
    description
    units
    key_stage
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    units
    key_stage
    year_number
    description
    learning_graph
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  year_number
  learning_graph
  description
  units
  key_stage
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

  # Overwrite this method to customize how year groups are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(year_group)
    "Year: #{year_group.year_number}"
  end
end