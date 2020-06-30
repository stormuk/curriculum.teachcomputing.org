module Types
  class YearGroupType < BaseObject
    field :id, ID, null: false
    field :year_number, String, null: false
    field :description, String, null: false
    field :key_stage, ID, null: false
    field :units, [Types::UnitType], null: true
  end
end
