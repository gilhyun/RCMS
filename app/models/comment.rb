class Comment < ActiveRecord::Base

  attr_accessible :user_id , :document_id , :version , :content
  
  belongs_to :user
  belongs_to :document , counter_cache:true

  paginates_per 5

  def self.list_updated(comments_page)
  	Comment.includes(:user).order("updated_at desc").page(comments_page)
  end

end
