class Document < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :attachfiles
  has_many :comments
end
