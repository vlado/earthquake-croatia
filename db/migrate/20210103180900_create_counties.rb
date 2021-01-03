class CreateCounties < ActiveRecord::Migration[6.1]
  def change
    create_table :counties do |t|
      t.string :name, unique: true, index: true
      t.timestamps
    end
  end
end
