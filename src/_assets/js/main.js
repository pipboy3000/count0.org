$(function(){
  // highlight.js
  hljs.initHighlightingOnLoad();

  // article images add class 'wide'
  $('.article-body p').has('img:not([src*="amazon"])').addClass('wide');

});
