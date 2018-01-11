class AddColumnLinkvideoToTask < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :link_video, :string
  end
end
