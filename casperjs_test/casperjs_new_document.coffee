casper= require('casper').create
	verbose: true
	logLevel: "warning"
	exitOnError: true
	safeLogs: true
	viewportSize:
		width: 1024
		height: 768

casper.options.onWaitTimeout = ->
  exit 1

casper.start "http://railsdev71.herokuapp.com/sessions/new" , ->
  this.capture("step1-login.png")
  this.fill("form#login_form", {"userid": "test","password": "test"}, true)

casper.waitForSelector("#new_document")

casper.then ->
  this.capture("step2-document_list.png")
  this.click("#new_document")

casper.waitForSelector("#document-content")

casper.then ->
  this.capture("step3-new_document.png")
	# 방법 1
  this.sendKeys("#document_title","from casperjs .....")
	# # 아미도 editor 라서 ??
  this.sendKeys("#document-content","from casperjs.... 20130320")
  this.click("button[type='submit']")

	# 방법 2
  #this.fill("form#new_document",{"document[title]": "casperjs..." , "document[content]": "ffff"}, true)

casper.waitForSelector("a[id='new_document']")

casper.then ->
  this.capture("step4-document_list.png")

casper.run()