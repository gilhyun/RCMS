class CreateAttachfiles < ActiveRecord::Migration
  def change
    create_table :attachfiles do |t|

      t.integer :document_id , null:false
      t.string :filename , null:false
      t.string :filepath
      t.integer :filesize , null:false

      t.timestamps
    end
  end
end
