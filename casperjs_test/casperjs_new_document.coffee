
casper= require('casper').create
	verbosr: true
	logLevel: "warning"
	exitOnError: true
	safeLogs: true
	viewportSize:
		width: 1024
		height: 768

casper.options.onWaitTimeout = ->
	casper.capture 'timeout.png'
	exit 1

casper.start "http://localhost:3000/documents" , ->
	
	casper.waitForText("LOGIN") # login 페이지 대기 
	casper.then ->
		casper.sendKeys("#userid","admin");
		casper.sendKeys("#password","admin");
		casper.click("input[type='submit']")
	
	casper.waitForSelector("#new-document")
	casper.then ->
		casper.click("#new-document")
			
	casper.waitForSelector("#document-content")

	casper.then ->
		casper.sendKeys("#document_title","from casperjs")
		# 아미도 editor 라서 ??
		casper.sendKeys("#document-content","from casperjs....")
	# casper.then ->
	# 	casper.fill('form#new_document',
	# 		{
	# 			document_title: "from casperjs"
	# 			document_content: "from casperjs...."
	# 		}
	# 	, true)
	casper.then ->
		casper.click("button[type='submit']")

	casper.waitForText("글쓰기")
	casper.then ->
		casper.capture("output.png")


casper.run()