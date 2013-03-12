class Addcountercachetodocuments < ActiveRecord::Migration
  def up
  	add_column :documents , :comments_count , :integer , default:0
  end

  def down
  	remove_column :documents , :comments_count
  end
end
