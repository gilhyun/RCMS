//= require ./upload/header
//= require ./upload/util
//= require ./upload/button
//= require ./upload/ajax.requester
//= require ./upload/handler.base
//= require ./upload/handler.form
//= require ./upload/handler.xhr
//= require ./upload/uploader.basic
//= require_directory ./upload
//= require bootstrap-wysihtml5

$ ->
  #html을 해석하게 한다.
  $('#tag_lists').popover({ html : true });