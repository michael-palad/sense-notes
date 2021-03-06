// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require tinymce.min.js
//= require data-confirm-modal
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  tinymce.remove();
  tinymce.init({ 
      selector: "textarea.content-edit",
      plugins: "image media link code codesample",
      toolbar: "undo redo | bold italic link | stylesheet | imag media | " +
               "code codesample"
  });
})