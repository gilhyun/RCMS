class DocumentsController < ApplicationController

  #before_filter :current_user , except:[:upload , :attachfile_download]
  
  def index

    @documents = Document.list_updated(params[:page])

    respond_to do |format|

      #
      # render partial:"list" 하면 layout 없이 그려진다.
      # 아래처럼 render "_list" 하면 제대로 그려진다.. 차이가 뭘까 ??
      # rendering이 생각보다 복잡해보인다.
      #
      format.html { render "_list"}
      # js 응답이므로 ajax.js.coffee를 찾을것이다. 
      # ajax.js.coffer를 다 적으면 deprecation warning이 로그에 나온다.
      format.js{ render "ajax" , locals:{page:"list"} } 
    end
  end

  def show
    @document=Document.show(params)
    @comments=@document.comments.list_updated(params[:page])

    respond_to do |format|
      format.html{ render "_show" }
      format.js{ render "ajax" , locals:{page:"show"} } 
    end

  end

  def new
    @document = Document.new

    respond_to do |format|
      format.html{ render "_form"}
      format.js{ render "ajax", locals:{page:"form"} } 
    end
  end

  def edit
    @document = Document.find(params[:id])
    
    respond_to do |format|
      format.html{ render "_form"}
      format.js{ render "ajax", locals:{page:"form"} } 
    end
  end

  def create

    @document = Document.new(params[:document])

    #
    # 수정되어야 한다.
    #
    @document.groupid=0
    @document.version=0

    respond_to do |format|
      if @document.save

        # 유저가 추가한 첨부파일 
        Attachfile.save_files(@document,params["time-token"])
        format.html { redirect_to documents_path }
      else
        # render "_form"으로 렌더링하면 error message가 표시가 안된다.
        format.js{ render "ajax", locals:{page:"form"} } 
      end
    end
  end

  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])

        # 신규추가된 upload file
        Attachfile.save_files(@document,params["time-token"])

        # 첨부된 파일중 삭제할것 
        Attachfile.update_files(@document,params[:attachfiles])

        format.html { redirect_to documents_path}
      else
        # render "_form"으로 렌더링하면 error message가 표시가 안된다.
        format.js{ render "ajax", locals:{page:"form"} } 
      end
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      
      #방법1 - 화면전체가 refresh될것이다.
      #format.js { render js: "window.location='#{documents_url}'"}

      #방법2 - 삭제후 페이지 번호를 누르면 show action으로 처리된다.. - > 원인이 뭐지 ??
      #@documents = Document.list_updated(params[:page])
      #format.js{ render "ajax", locals:{page:"list"} } 
      
      #방법3 - 제일 무난한 방법인것 같다.
      format.all{ redirect_to documents_path}
    end
  end

  # 업로드 첨부파일정보 임시저장
  def upload

    tmpfile=Tmpfile.new

    tmpfile.ufilename=File.basename(params["our-file"].tempfile)
    tmpfile.ufilepath=File.dirname(params["our-file"].tempfile)
    tmpfile.filesize=File.size(params["our-file"].tempfile)
    tmpfile.filename=File.basename(params["our-file"].original_filename)
    tmpfile.time_token=params["time-token"]

    tmpfile.save!

    # respond_to do |format|
    #   format.all{ render nothing:true}
    # end
  end

  # 첨부파일 다운로드
  def attachfile_download
    # 0: 파일명을 포함한 파일 전체경로
    # 1: 파일명
    finfo=Attachfile.download_filename(params)
    send_file(finfo[0], filename:"#{finfo[1]}" , disposition:'attachment')
  end
end
