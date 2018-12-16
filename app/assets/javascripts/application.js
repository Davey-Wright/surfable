// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require foundation
//= confirmation_modal

$(document).on('turbolinks:load', function() {
  $(document).foundation().confirmWithReveal();
});


let open_modal = function(content, callback){
  let $modal = $('#modal'),
      $modal_content = $('.modal_content');

  $($modal_content).html(content).promise().done(function(){
    $modal.foundation('open');
  })

  $modal.on('closed.zf.reveal', function(e){
    $($modal_content).html('');
  });

  if (typeof callback === "function") {
    $modal.on('open.zf.reveal', callback());
  }
}


let close_modal_and_redirect = function(url){
  setTimeout(function() {
    $('#modal').foundation('close');
  }, 2000);

  $('#modal').on('closed.zf.reveal', function(){
    window.location.replace(url)
  });
}
