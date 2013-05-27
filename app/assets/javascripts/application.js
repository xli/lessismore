// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $('#dashboard').carousel();
  if ($('#dashboard').length > 0) {
    setTimeout(function(){
      window.location.href = '/dashboard';
    }, 600 * 1000);
  }
  $('#test-revision-extraction').click(function(e) {
    $('#test-result').text('loading...');
    $.ajax({
      url: '/test_revision_extraction',
      data: {
        url: $('#continuous_deployment_deployed_revision_url').val(),
        extract_regex: $('#continuous_deployment_deployed_revision_extract_regex').val()
      }
    }).done(function(revision) {
      $('#test-result').text(revision);
    });
  });
});
