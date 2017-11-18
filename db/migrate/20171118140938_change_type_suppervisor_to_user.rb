class ChangeTypeSuppervisorToUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :suppervisor, :integer, default: 0
  end
end
