class Addcolumntmpfiles < ActiveRecord::Migration
  def up
  	add_column :tmpfiles , :filesize , :integer
  end

  def down
  	remove_column :tmpfiles , :filesize
  end
end
