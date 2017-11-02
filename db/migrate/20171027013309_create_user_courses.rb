class CreateUserCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_courses do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status, default: 0
      t.index [:course_id, :user_id], unique: true

      t.timestamps
    end
  end
end
