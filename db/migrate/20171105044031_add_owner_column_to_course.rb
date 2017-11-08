class AddOwnerColumnToCourse < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :users, index: true
  end
end
