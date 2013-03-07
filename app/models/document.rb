class Document < ActiveRecord::Base

  attr_accessible :title , :content , :user_id
  belongs_to :user
  belongs_to :category
  has_many :attachfiles , dependent: :destroy
  has_many :comments , dependent: :destroy

  paginates_per 10

  def self.list_updated(page)
  	Document.includes(:comments , :attachfiles).order("updated_at desc").page(page)
  end

  def self.show(params)
  	Document.includes(:attachfiles).find(params[:id])
  end

end
