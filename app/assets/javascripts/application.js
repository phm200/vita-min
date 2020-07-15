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
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require cfa_styleguide_main

var immediateUpload = (function() {
  var uploader = function() {
    var fileUploadForm = $('form#file-upload-form');
    var fileInputElements = fileUploadForm.find('input[type="file"][data-upload-immediately]');

    // hide the file input
    $(fileInputElements).addClass('file-upload__input');

    // hide the submit button fallback
    fileUploadForm.find("button[type=submit]").hide();
    // show the label button
    fileUploadForm.find('label.js-only').show();

    // submit the form immediately after a file is uploaded
    fileInputElements.change(function(_event) {
      document.body.classList.add('submitting');
      fileUploadForm.submit();
    });
  };

  return {
    init: uploader
  }
})();

$(document).ready(function() {
  ajaxMixpanelEvents.init();
});

// Enabled & disabled within warnOnNavigation()
let _warnOnNavigation = false;

function warnOnNavigation() {
    window.addEventListener('beforeunload', function (e) {
        // Copy string from Chrome; note that per
        // https://developer.mozilla.org/en-US/docs/Web/API/WindowEventHandlers/onbeforeunload ,
        // we cannot customize the string in most browsers. The browser might localize this if
        // we are lucky.
        if (_warnOnNavigation) {
            e.returnValue = "Changes you made may not be saved.";
        } else {
            delete e['returnValue'];
        }
    });
    window.addEventListener("DOMContentLoaded", function() {
        $('button').click(function() {
            _warnOnNavigation = false;
        });
        $('a').click(function() {
            _warnOnNavigation = false;
        });
    });
}
