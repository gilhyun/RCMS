class CreateTmpfiles < ActiveRecord::Migration
  def change
    create_table :tmpfiles do |t|
      t.string :ufilename
      t.string :ufilepath
      t.string :filename

      t.timestamps
    end
  end
end
