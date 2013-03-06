class Addcolumntimetoken < ActiveRecord::Migration
  def up
  	add_column :tmpfiles , :time_token , :string 
  end

  def down
  	remove_column :tmpfiles , :time_token
  end
end
