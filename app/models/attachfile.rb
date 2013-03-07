class Attachfile < ActiveRecord::Base
  attr_accessible :document_id, :filename, :filepath, :filesize

  belongs_to :document

  # create시 첨부파일정보 저장
  # time_token :  현재 upload된 파일목록을 구분할 시간정보
  def self.save_files(document,time_token)
  	file_lists=Tmpfile.find_by_time_token(time_token)
  	file_lists.each do |tf|
  		data={document_id:document.id, filename:tf.filename, filepath:tf.ufilepath, filesize:tf.filesize}
  		att_file=Attachfile.new(data)
  		att_file.save!
  	end
  end

  # update 시 첨부파일 삭제 처리 
  def self.update_files(file_lists)
  	
  	return unless file_lists

  	file_lists.values.each do |file_id|
  		af=Attachfile.find(file_id)
  		af.destroy
  	end
  end

end
