# encoding: utf-8
class Category < ActiveRecord::Base
  attr_accessible :name , :description
  has_many :documents

  paginates_per 10 # kaminari paging parameter

  validates_presence_of :name , message:" 을(를)입력해야 합니다."
end
