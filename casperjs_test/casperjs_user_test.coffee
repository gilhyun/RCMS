casper= require('casper').create
  verbose: true
  safeLogs: true
  viewportSize:
    width:1024
    height:768

casper.options.onWaitTimeout = ->
  #casper.capture 'timeout.png'
  exit 1

# LOGIN
casper.start "http://railsdev71.herokuapp.com/users/new", ->
  this.fill("form#login_form", {"userid": "admin","password": "admin2"}, true)

# 사용자 목록
casper.waitForSelector("#user_manage")
casper.then ->
  this.click("#users_manage")

casper.waitForSelector("#add_new_user")


#사용자 등록
casper.then ->
  this.capture("사용자목록.png")
  this.click("#add_new_user")

casper.waitForSelector("#submit_user")


casper.then ->
  this.capture("사용자등록.png")
  this.fill("form#new_user",{"user[userid]":"AAA","user[password]":"AAA","user[email]":"AAA"}, true)
  this.capture("사용자데이타입력.png")

casper.waitForSelector("#user_manage")

casper.then ->
  this.capture("사용자등록완료.png")


casper.run()

