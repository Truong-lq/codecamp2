class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.boolean :is_correct, default: false
      t.text :content
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
