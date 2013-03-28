# 각 액션에 대해 스크립트가 길어지면 액션별 각각의 coffee 파일을 만든다.

$("#rcms-main").html("<%= j(render partial:"#{page}") %>")

<% if page=="admin/documents/list" %>

$ ->
  $(".icon-edit").tooltip()
  $(".icon-remove").tooltip()

  $("#chk_all").click ->
    if $(this).is(":checked")
      $("input[id^=chk_document]").each -> $(this).prop("checked",true)
      # $(elem).prop("checked",true) for elem in $("input[id^=chk_document]")
    else
      $("input[id^=chk_document]").each -> $(this).prop("checked",false)
      # $(elem).prop("checked",false) for elem in $("input[id^=chk_document]")

<% end %>

