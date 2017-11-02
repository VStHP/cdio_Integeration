class CreateUserSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :user_subjects do |t|
      t.references :user, foreign_key: true
      t.references :course_subject, foreign_key: true
      t.integer :status, default: 0
      t.index [:user_id, :course_subject_id], unique: true

      t.timestamps
    end
  end
end
