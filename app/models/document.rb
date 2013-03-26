# encoding: utf-8
class Document < ActiveRecord::Base

  attr_accessible :title , :content , :user_id , :category_id

  belongs_to :user
  belongs_to :category , counter_cache:true
  has_many :attachfiles , dependent: :destroy
  has_many :comments , dependent: :destroy

  validates_presence_of :title , :user_id , :category_id , message:" 을(를)입력해야 합니다."

  paginates_per 10

  def self.list_updated(page)
  	Document.includes(:user).order("updated_at desc").page(page)
  end

  def self.show(params)
    Document.includes(:category,:user,:attachfiles).find(params[:id])
  end

  def to_param 
    [id, title.parameterize.to_s].join("-")  # routing 에 영향을 주지 않는다.
  end

end
