# encoding: utf-8
class SessionsController < ApplicationController
  

  # login ui
  def new

    test_user=User.find_by_userid("test")
    unless test_user
      u=User.create(userid:"test", email:"railsdev71@gmail.com",password:"test")
      u.save!
    end

    if params[:cmd]=="login"
    end

    if params[:cmd]=="logout"
      session[:userid]=nil
    end

    render "new"
  end

  #login 체크
  def create
    user = User.find_by_userid(params[:userid])

    # user 정보생성 - fixtures로는 password_digest에 값이 안들어감.
    # 넣을 방법을 생각해볼것..
    
    # 1.upto(5) do |inx|
    #   u=User.create(:userid => "kim#{inx}", :password => "kim#{inx}")
    #   u.save
    # end

    if user && user.authenticate(params[:password])
      session[:userid] = user.id
      redirect_to documents_url, :notice => "Logged in!"
    else
      flash.now.alert = "아이디, 패스워드가 잘못 입력되었습니다."
      render "new"
    end
  end

end