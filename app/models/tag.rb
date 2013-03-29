class Tag < ActiveRecord::Base
  attr_accessible :document_id, :name

  has_many :documents
end
