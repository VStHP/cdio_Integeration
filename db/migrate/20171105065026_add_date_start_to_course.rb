class AddDateStartToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :date_start, :date, index: true
  end
end
