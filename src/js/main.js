var jQuery = require('jquery');
var hljs = require('highlight.js');

(function($){

$(function() {

  // highlight.js
  hljs.initHighlightingOnLoad();


  var header = document.querySelector('.layout-document > .header');
  var header_height = getComputedStyle(header).height.split('px')[0];

  var headerScroll = function(e) {
    if (window.pageYOffset < (header_height)) {
      if (header.classList.contains('-mini')) {
        header.classList.remove('-mini');
      }
    } 

    if (window.pageYOffset > (header_height / 2)) {
      if (!header.classList.contains('-mini')) {
        header.classList.add('-mini');
      }
    }
  }

  window.addEventListener('scroll', headerScroll, false);
});

})(jQuery);
