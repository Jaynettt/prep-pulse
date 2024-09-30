class CreatePulseCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :pulse_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :pulse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
