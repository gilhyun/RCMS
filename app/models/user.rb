# encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :admin, :email, :userid, :password
  
  has_secure_password
  
  paginates_per 10 # kaminari paging parameter

  # error 가 발생할경우 메세지 처리는 
  # config/locales/ko.yml , en.yml등에 작성되어 있다.
  validates_presence_of :userid , :email , :password , message:" 을(를)입력해야 합니다."
end
