class CreateCourseSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :course_subjects do |t|
      t.references :course, foreign_key: true
      t.references :subject, foreign_key: true
      t.integer :status, default: 0
      t.date :date_start
      t.date :date_end
      t.index [:course_id, :subject_id], unique: true

      t.timestamps
    end
  end
end
