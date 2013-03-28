$("#rcms-main").html("<%= j(render partial:"#{page}") %>")

<% if page=="admin/documents/list" %>

$ ->

  $("#chk_all").click ->
    if $(this).is(":checked")
      #
      # attr은 안되고, prop는 된다. 이버전만 그런것인가 ??
      # 차이점에 대한 설명이 http://api.jquery.com/prop/ 에 있다.
      #
      $("input[id^=chk_document]").each -> $(this).prop("checked",true)
      # $(elem).prop("checked",true) for elem in $("input[id^=chk_document]")
    else
      $("input[id^=chk_document]").each -> $(this).prop("checked",false)
      # $(elem).prop("checked",false) for elem in $("input[id^=chk_document]")

<% end %>

<% if page=="list_category" %>

$ ->

  $("#chk_all").click ->
    if $(this).is(":checked")
      #
      # attr은 안되고, prop는 된다. 이버전만 그런것인가 ??
      # 차이점에 대한 설명이 http://api.jquery.com/prop/ 에 있다.
      #
      $("input[id^=chk_category]").each -> $(this).prop("checked",true)
      # $(elem).prop("checked",true) for elem in $("input[id^=chk_category]")
    else
      $("input[id^=chk_category]").each -> $(this).prop("checked",false)
      # $(elem).prop("checked",false) for elem in $("input[id^=chk_category]")

<% end %>

<% if page=="list_user" %>

$ ->

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
