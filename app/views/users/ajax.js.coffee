# 각 액션에 대해 스크립트가 길어지면 액션별 각각의 coffee 파일을 만든다.
$("#rcms-main").html("<%= j(render partial:"#{page}") %>")

<% if page=="list" %>

$ ->
  $(".icon-edit").tooltip()
  $(".icon-remove").tooltip()

  $("#chk_all").click ->
    if $(this).is(":checked")
      #
      # attr은 안되고, prop는 된다. 이버전만 그런것인가 ??
      # 차이점에 대한 설명이 http://api.jquery.com/prop/ 에 있다.
      #
      $("input[id^=chk_user]").each -> $(this).prop("checked",true)
      # $(elem).prop("checked",true) for elem in $("input[id^=chk_user]")
    else
      $("input[id^=chk_user]").each -> $(this).prop("checked",false)
      # $(elem).prop("checked",false) for elem in $("input[id^=chk_user]")

<% end %>
