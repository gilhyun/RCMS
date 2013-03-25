# 각 액션에 대해 스크립트가 길어지면 액션별 각각의 coffee 파일을 만든다.

$("#rcms-main").html("<%= j(render partial:"#{page}") %>")

<% if page=="list" %>

$ ->
  $(".icon-edit").tooltip()
  $(".icon-remove").tooltip()

  $("#chk_all").click ->
    if $(this).is(":checked")
      $("input:checkbox[id^=chk_category]").each -> $(this).attr("checked",true)
    else
      $("input:checkbox[id^=chk_category]").each -> $(this).attr("checked",false)

<% end %>
