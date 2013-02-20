class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.integer :user_id , null:false
      t.integer :document_id , null:false
      t.integer :version , null:false
      t.text :content

      t.timestamps
    end
  end
end
