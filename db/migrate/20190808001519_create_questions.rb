class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :subject, foreign_key: true
      t.references :user, foreign_key: true
      t.string :content
      t.integer :question_type, default: 1
      t.integer :level, default: 0

      t.timestamps
    end
  end
end
