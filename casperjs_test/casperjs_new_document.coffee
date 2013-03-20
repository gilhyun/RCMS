
casper= require('casper').create
	verbosr: true
	logLevel: "warning"
	exitOnError: true
	safeLogs: true
	viewportSize:
		width: 1024
		height: 768

casper.options.onWaitTimeout = ->
 	#casper.capture 'timeout.png'
 	exit 1

casper.start "http://localhost:3000/sessions/new" , ->
	console.log(this.getTitle())
	this.fill("form#login_form", {"userid": "admin","password": "admin"}, true)

# wait..관련 함수는 이렇게 밖에 쓰는게 좋은듯하다..
# then 안에서 잘 안되는 경우가 있는것 같다.
casper.waitForSelector("#new-document")

casper.then ->
	this.click("#new_document")

casper.waitForSelector("#document-content")

casper.then ->		

	# 방법 1
	# this.sendKeys("#document_title","from casperjs .....")
	# # 아미도 editor 라서 ??
	# this.sendKeys("#document-content","from casperjs.... 20130320")
	# this.click("button[type='submit']")

	# 방법 2
	this.fill("form#new_document",{"document[title]":"casperjs test..." , "document[content]":"ffff"}, true)

# console.log(casper.getCurrentUrl())
casper.waitForText("글쓰기")

casper.then ->
		this.capture("output.png")


casper.run()