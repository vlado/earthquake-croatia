class CreateReasons < ActiveRecord::Migration[6.1]
  def change
    create_table :reasons do |t|
      t.references :ad, null: false
      t.integer :code
      t.string :comment

      t.timestamps
    end
  end
end
