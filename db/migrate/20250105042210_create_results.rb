class CreateResults < ActiveRecord::Migration[7.2]
  def change
    create_table :results do |t|
      t.integer :point
      t.references :test, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
