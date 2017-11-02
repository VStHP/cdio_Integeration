class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :gender
      t.date :date_start
      t.string :university
      t.string :program
      t.string :avatar
      t.boolean :suppervisor
      t.string :password_digest
      t.string :reset_digest
      t.datetime :reset_send_at
      t.string :remember_digest


      t.timestamps
    end
  end
end
