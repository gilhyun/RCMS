class Removecolumntousers < ActiveRecord::Migration
  def up
  	remove_column :users , :salt
  	remove_column :users , :password

  end

  def down
  	add_column :users , :salt , :string
  	add_column :users , :password , :string
  end
end
