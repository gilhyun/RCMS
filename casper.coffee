
casper= require('casper').create()

casper.start "http://localhost:3000/documents"

casper.thenOpen "http://localhost:3000/sessions/new"

casper.then ->
  @fill "form[action='/sessions'", {name:"test", password:"test"} , true

casper.thenClick "btn.btn-primary"

#casper.then ->
#  @echo "page url is #{@getCurrentUrl()}"
#  @echo "page title is #{@getTitle()}"




casper.run()