class AddSomeColumnsToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :program, :string
    add_column :courses, :training_standard, :string
    add_index :courses, :program
    add_index :courses, :training_standard
  end
end
