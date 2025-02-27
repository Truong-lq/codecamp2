class CreateUserAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :user_answers do |t|
      t.references :result, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
