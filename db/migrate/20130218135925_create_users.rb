class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :userid
      t.string :email
      t.boolean :admin
      t.string :password
      t.string :salt

      t.timestamps
    end
  end
end
