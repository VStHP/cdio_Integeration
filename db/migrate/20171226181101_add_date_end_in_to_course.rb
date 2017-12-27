class AddDateEndInToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :date_end, :date
  end
end
