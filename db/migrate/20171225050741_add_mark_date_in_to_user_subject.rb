class AddMarkDateInToUserSubject < ActiveRecord::Migration[5.1]
  def change
    add_column :user_subjects, :date_start, :date
    add_column :user_subjects, :date_end, :date
  end
end
