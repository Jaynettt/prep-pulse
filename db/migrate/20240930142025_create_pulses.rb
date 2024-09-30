class CreatePulses < ActiveRecord::Migration[7.2]
  def change
    create_table :pulses do |t|
      t.string :job_role
      t.string :job_description
      t.string :company_name
      t.string :company_description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
