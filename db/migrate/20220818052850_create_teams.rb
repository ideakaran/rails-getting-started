class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :division, null: false, foreign_key: true
      t.string :managerName
      t.string :managerContact

      t.timestamps
    end
  end
end
