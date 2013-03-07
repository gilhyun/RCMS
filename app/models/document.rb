class Document < ActiveRecord::Base

  attr_accessible :title , :content , :user_id
  belongs_to :user
  belongs_to :category
  has_many :attachfiles , dependent: :destroy
  has_many :comments , dependent: :destroy

  paginates_per 5

  def self.list_updated(page)
  	Document.includes(:attachfiles).order("updated_at desc").page(page)
  end
end
