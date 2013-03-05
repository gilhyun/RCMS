class Editdocuments < ActiveRecord::Migration
  def up
  	change_column :documents , :attachfile_id , :integer , null:true
  end

  def down
  	change_column :documents , :attachfile_id , :integer , null:false
  end
end
