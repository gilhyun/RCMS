class AddDocumentCountToCategory < ActiveRecord::Migration
  def up
    add_column :categories , :documents_count , :integer , default:0
  end

  def down
    remove_column :categories , :documents_count
  end
end
