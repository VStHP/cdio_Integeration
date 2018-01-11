class AddDefaultStatusCandidates < ActiveRecord::Migration[5.1]
  def change
    change_column :candidates, :status, :int, default: 0
  end
end
