class DocumentsController < ApplicationController

  before_filter :current_user , except:[:upload , :attachfile_download]
  
  def index

    session[:search]="document"

    unless params[:category_id]
      @category=Category.first 
    else
      @category=Category.find(params[:category_id])
    end

    @documents = @category.documents.list_updated(params[:page])

    respond_to do |format|

      #
      # render partial:"list" 하면 layout 없이 그려진다.
      # 아래처럼 render "_list" 하면 제대로 그려진다.. 차이가 뭘까 ??
      # rendering이 생각보다 복잡해보인다.
      #
      format.html { render "_list"}
      # js 응답이므로 ajax.js.js.coffee를 찾을것이다. 
      # ajax.js.js.coffer를 다 적으면 deprecation warning이 로그에 나온다.
      format.js{ render "ajax.js" , locals:{page:"list"} } 
    end
  end

  def admin_index

    session[:search]="admin_document"

    @documents=Document.includes(:category,:user).all

    @documents=Kaminari.paginate_array(@documents).page(params[:page]).per(search_options[:list_per])


    respond_to do |format|
      format.js{ render "ajax.js", locals:{page:"admin/documents/list"}}
    end
  end


  def show
    @document=Document.show(params)

    respond_to do |format|
      #format.html{ render "_show" }
      format.js{ render "ajax.js" , locals:{page:"show"} } 
    end

  end

  # admin 에서 조회시 bootstrap modal 사용시 호출되는 액션 
  def modal_show
    @document=Document.show(params)

    respond_to do |format|
      #format.html{ render "_show" }
      format.js{ render "modal_show.js" }
    end 
  end

  def new
    if params[:category_id]
      @category=Category.find(params[:category_id])
      @document=@category.documents.new
    else
      @document = Document.new
    end

    respond_to do |format|
      format.html{ render "_form"}
      format.js{ render "ajax.js", locals:{page:"form"} } 
    end
  end

  def edit
    @document = Document.show(params)
    
    respond_to do |format|
      format.html{ render "_form"}
      format.js{ render "ajax.js", locals:{page:"form"} } 
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
        format.js{ render "ajax.js", locals:{page:"form"} } 
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
        format.js{ render "ajax.js", locals:{page:"form"} } 
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
      #format.js{ render "ajax.js", locals:{page:"list"} } 
      
      #방법3 - 제일 무난한 방법인것 같다.
      format.all{ redirect_to documents_path}
    end
  end

  # 업로드 첨부파일정보 임시저장
  def upload

    tmpfile=Tmpfile.new

    tmpfile.ufilename=File.basename(params["qqfile"].tempfile)
    tmpfile.ufilepath=File.dirname(params["qqfile"].tempfile)
    tmpfile.filesize=File.size(params["qqfile"].tempfile)
    tmpfile.filename=File.basename(params["qqfile"].original_filename)
    tmpfile.time_token=params["time_token"]

    tmpfile.save!

    respond_to do |format|
      # 주의 따옴표가 아니면 fineupload에서 못알아듣는다.
      format.all { render text: "{\"success\":true}"}
    end
  end

  # 첨부파일 다운로드
  def attachfile_download
    # 0: 파일명을 포함한 파일 전체경로
    # 1: 파일명
    finfo=Attachfile.download_filename(params)
    send_file(finfo[0], filename:"#{finfo[1]}" , disposition:'attachment')
  end
end
