class UsersController < ApplicationController

  before_filter :current_user
  
  def index
    @users = User.order("updated_at desc").page(params[:page])

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
    @user = User.find(session[:userid])

    respond_to do |format|
      format.html{ render "_show" }
      format.js{ render "ajax" , locals:{page:"show"} } 
    end

  end

  def new
    @user = User.new

    respond_to do |format|
      format.html{ render "_form"}
      format.js{ render "ajax", locals:{page:"form"} } 
    end
  end

  def edit
    @user = User.find(session[:userid])
    
    respond_to do |format|
      format.html{ render "_form"}
      format.js{ render "ajax", locals:{page:"form"} } 
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path }
      else
        # render "_form"으로 렌더링하면 error message가 표시가 안된다.
        format.js{ render "ajax", locals:{page:"form"} } 
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        # 관리자가 아닌 사람도 자신의 정보를 수정성공시 show로 가도록 한다.
        format.html { redirect_to user_path(@user) }
      else
        # render "_form"으로 렌더링하면 error message가 표시가 안된다.
        format.js{ render "ajax", locals:{page:"form"} } 
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    respond_to do |format|
      format.all{ redirect_to users_path}
    end

  end
end
