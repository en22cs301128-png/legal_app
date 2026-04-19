class CreateCases < ActiveRecord::Migration[7.1]
  def change
    create_table :cases do |t|
      t.string :title, null: false
      t.text :description
      t.string :status, null: false, default: "open"
      t.string :client_name, null: false

      t.timestamps
    end
  end
end
