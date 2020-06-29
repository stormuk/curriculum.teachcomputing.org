class RemoveTitleFromKeyStagesAndAddKsNumber < ActiveRecord::Migration[6.0]
  def change
    remove_column :key_stages, :title, :string
    add_column :key_stages, :level, :string
  end
end
