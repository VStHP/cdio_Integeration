class AddSomeColumnsToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :organization, :string
    add_column :courses, :program, :string
    add_column :courses, :training_standard, :string
    add_index :courses, :organization, null: false
    add_index :courses, :program, null: false
    add_index :courses, :training_standard, null: false
  end
end
