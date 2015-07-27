var jQuery = require('jquery');
var hljs = require('highlight.js');

(function($){

$(function() {

  // highlight.js
  hljs.initHighlightingOnLoad();

  // article images add class 'wide'
  $('.article-body p').has('img:not([src*="amazon"])').addClass('wide');

});

})(jQuery);
