class CategoriesController < ApplicationController

	before_filter :current_user
  
  def index
    @categories = Category.order("name desc").page(params[:page])

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
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html{ render "_show" }
      format.js{ render "ajax" , locals:{page:"show"} } 
    end

  end

  def new
    @category = Category.new

    respond_to do |format|
      format.html{ render "_form"}
      format.js{ render "ajax", locals:{page:"form"} } 
    end
  end

  def edit
    @category = Category.find(params[:id])
    
    respond_to do |format|
      format.html{ render "_form"}
      format.js{ render "ajax", locals:{page:"form"} } 
    end
  end

  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path }
      else
        # render "_form"으로 렌더링하면 error message가 표시가 안된다.
        format.js{ render "ajax", locals:{page:"form"} } 
      end
    end
  end

  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_path}
      else
        # render "_form"으로 렌더링하면 error message가 표시가 안된다.
        format.js{ render "ajax", locals:{page:"form"} } 
      end
    end
  end

  def destroy
    category = Category.find(params[:id])
    if category.documents.count ==0
      category.destroy
    else
    end

    respond_to do |format|
      format.all{ redirect_to categories_path}
    end

  end
end
