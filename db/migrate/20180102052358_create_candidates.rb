class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :expected_intern
      t.text :note
      t.string :cv_url

      t.timestamps
    end
  end
end
