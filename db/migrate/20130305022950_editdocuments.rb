class Editdocuments < ActiveRecord::Migration
  def up
  	change_column :documents , :attachfile_id , :integer
  end

  def down
  	change_column :documents , :attachfile_id 
  end
end
