
casper= require('casper').create({verbosr:true, logLevel:"debug"})

casper.start "http://localhost:3000/documents" , ->
	
	casper.waitForText("LOGIN") # login 페이지 대기 
	casper.then ->
		casper.sendKeys("#userid","test");
		casper.sendKeys("#password","test");
		casper.click("input[type='submit']")
	
	casper.waitForText("CATEGORIES")
	casper.then ->
		casper.click("#new-document")
			
	casper.waitForSelector("#document-content")
	#casper.then ->
	#	casper.capture 'output.png'

casper.run()