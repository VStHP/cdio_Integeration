class CreateDetailLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :detail_links do |t|
      t.string :name
      t.string :link
      t.references :course, foreign_key: true
      t.references :subject, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
