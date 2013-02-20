# -*- encoding: utf-8 

require 'watir' 

brw=Watir::Browser.new 
brw.goto 'http://localhost:3000/users' 

lnk=brw.link(:text , "수정") 
lnk.click 

# waiting... because of ajax 
Watir::Wait.until do 
  if brw.text_field(:id, "user_userid").exist? 
  	uid=brw.text_field(:id, "user_userid")
  	uid.set("from watir")
  	sleep 2
  	brw.button(:text,"저장").click
  end
end 

# brw.goto 'http://localhost:3000/users' 
# Watir::Wait.until do
# 	brw.link(:text,"1").click
# 	sleep 2
# 	brw.link(:text,"2").click
# 	sleep 2
# 	brw.link(:text,"3").click
# 	sleep 2
# 	brw.link(:text,"4").click
# 	sleep 2
# 	brw.link(:text,"3").click
# 	sleep 2
# 	brw.link(:text,"2").click
# 	sleep 2
# 	brw.link(:text,"1").click	
# end


#cur_time=Time.now.strftime("%Y%m%d-%H%M%S") 
#title=brw.text_field(:id , 'mylist_title') 
#title.set("this is from watir: #{cur_time}") 

#frm=brw.form(:class , "edit_mylist") 
#frm.submit 

#brw.goto 'http://localhost/mylists' 

#link_show=brw.link(:name,'link_show2') 
#link_show.click 

#brw.close