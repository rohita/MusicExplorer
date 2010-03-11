// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

function showUpload() {
	$("#file-status").hide();
	$("#upload").show();
}

function showFileStatus() {
	$("#upload").hide();
	$("#file-status").show();
}


