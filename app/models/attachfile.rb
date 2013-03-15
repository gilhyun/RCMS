# encoding: utf-8
require 'fileutils'

class Attachfile < ActiveRecord::Base
  attr_accessible :document_id, :filename, :filepath, :filesize

  belongs_to :document

  @upload_base="#{Rails.root}#{ENV['UPLOAD_PATH']}"

  #임시 저장된 첨부파일을 지정된 디렉토리로 복사한다.
  #디렉토리이름은 document.id 값이다.
  def self.upload_file_copy(document,file_lists,attachfile)

    base_dir=File.join(@upload_base,document.id.to_s)
    FileUtils.mkdir(base_dir) unless Dir.exist?(base_dir)

    file_lists.each do |tf|
      src=File.join(tf.ufilepath,tf.ufilename)
      #파일명은 자신의 id 값이다.
      dest=File.join(base_dir,attachfile.id.to_s)
      FileUtils.cp(src,dest)
    end
  end

  # create시 첨부파일정보 저장
  # time_token :  현재 upload된 파일목록을 구분할 시간정보
  def self.save_files(document,time_token)
  	file_lists=Tmpfile.find_by_time_token(time_token)
    base_dir=File.join(@upload_base,document.id.to_s)
  	file_lists.each do |tf|
  		data={document_id:document.id, filename:tf.filename, filepath:"#{base_dir}", filesize:tf.filesize}
  		att_file=Attachfile.new(data)
      #db 저장
  		att_file.save!
      #실제파일 복사
      upload_file_copy(document, file_lists,att_file)
  	end

    #tmpfiles db 삭제
    file_lists.each do |tf|
      af=Tmpfile.find(tf)
      # db 삭제
      af.destroy
    end

  end

  # update 시 첨부파일 삭제 처리 
  def self.update_files(document,file_lists)
  	
  	return unless file_lists

  	file_lists.values.each do |file_id|
  		af=Attachfile.find(file_id)
      # db 삭제
  		af.destroy
      # 실제 파일 삭제
      FileUtils.rm_rf(File.join(@upload_base,document.id.to_s,af.id.to_s))
  	end
  end

  def self.download_filename(params)
    af=Attachfile.find(params[:attachfile_id])
    filepath=File.join(@upload_base,params[:id].to_s,af.id.to_s)
    return [filepath, af.filename]
  end

end
