class Comment < ActiveRecord::Base

	attr_accessible :user_id , :document_id , :version , :content
  
  belongs_to :user
  belongs_to :document

  paginates_per 5

  def self.list_updated(page)
  	Comment.order("updated_at desc").page(page)
  end

end
