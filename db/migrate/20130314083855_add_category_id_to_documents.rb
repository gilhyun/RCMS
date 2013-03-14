class AddCategoryIdToDocuments < ActiveRecord::Migration
  def up
  	add_column :documents , :category_id , :integer , null: :false
  end

  def down
  	remove_column :documents , :category_id
  end
end
