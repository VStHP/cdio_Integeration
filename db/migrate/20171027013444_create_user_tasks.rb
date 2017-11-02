class CreateUserTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tasks do |t|
      t.references :user_subject, foreign_key: true
      t.references :task, foreign_key: true
      t.integer :status, default: 0
      t.date :date_receive
      t.date :date_finish
      t.index [:user_subject_id, :task_id], unique: true

      t.timestamps
    end
  end
end
