class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
