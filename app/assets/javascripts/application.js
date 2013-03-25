// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap


$(document).ajaxStart(function(){
  $("#icon-loading").show();
});

$(document).ajaxComplete(function(){
  $("#icon-loading").hide();
});


// history 관리
// 문서 작성시 분류를 선택하면 여기에 반응. 목록으로 이동한다. 
// 일단 분류 클릭을 noclk를 부여하고, 분류클릭을 제외했다. 
// if (history && history.pushState){
//   $(function(){
//    $('body').on('click', 'a', function(e){
//       $.getScript(this.href);
//       history.pushState(null, '', this.href);
//     });
//     $(window).bind("popstate", function(){
//       $.getScript(location.href);
//     });
//   });
// }