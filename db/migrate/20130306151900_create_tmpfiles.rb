class CreateTmpfiles < ActiveRecord::Migration
  def change
    create_table :tmpfiles do |t|
      t.string :ufilename , null:false
      t.string :ufilepath , null:false
      t.string :filename , null:false

      t.timestamps
    end
  end
end
