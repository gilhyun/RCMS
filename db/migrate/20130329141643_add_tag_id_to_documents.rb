# encoding: utf-8
class AddTagIdToDocuments < ActiveRecord::Migration
  def up
    add_column :documents , :tag_id , :integer
    add_index :tags , :name
    # has_and_belongs_to_many
    #execute "CREATE TABLE documents_tags(document_id integer not null , tag_id integer not null)"
  end

  def down
    remove_column :documents , :tag_id
    remove_index :tags , :name
    #execute "DROP TABLE documents_tags"
  end

end
