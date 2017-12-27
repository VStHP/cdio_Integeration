class ChangeTypeDataOfDesInSubject < ActiveRecord::Migration[5.1]
  def change
    change_column :subjects, :description, :text
    change_column :courses, :description, :text
    change_column :tasks, :description, :text
  end
end
