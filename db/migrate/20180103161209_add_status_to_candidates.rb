class AddStatusToCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :status, :int
  end
end
