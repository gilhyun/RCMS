class Document < ActiveRecord::Base

  attr_accessible :title , :content , :user_id
  belongs_to :user
  belongs_to :category
  has_many :attachfiles
  has_many :comments

  paginates_per 5

  def self.list_updated(page)
  	Document.order("updated_at desc").page(page)
  end
end
