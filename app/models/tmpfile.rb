class Tmpfile < ActiveRecord::Base
  attr_accessible :filename, :ufilename, :ufilepath , :time_token

  def self.find_by_time_token(time_token)
  	Tmpfile.where("time_token=?",time_token)
  end

end
