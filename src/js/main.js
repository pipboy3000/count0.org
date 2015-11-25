require('babel-polyfill');
var _            = require('lodash');
var hljs         = require('highlight.js');
var React        = require('react');
var ReactDOM     = require('react-dom');
var RelatedPosts = require('./related-posts.js');

// shorthand
var q = (selector) => document.querySelector(selector)
var qa = (selector) => document.querySelectorAll(selector);

var headerScrollHandler = (e) => {
  var header = q('.layout-document > .header');
  var header_height = getComputedStyle(header).height.split('px')[0];

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

var related_posts_mount = q('.related-posts-container');

((doc) => {
doc.addEventListener('DOMContentLoaded', (e) => {
  // highlight.js
  hljs.initHighlightingOnLoad();

  // mobile header transform 
  window.addEventListener('scroll', headerScrollHandler, false);

  // related posts
  if (related_posts_mount) {
    var categories = _.map(qa('.meta .category'), item => item.innerText);
    ReactDOM.render(<RelatedPosts categories={categories} />, related_posts_mount);
  }

}, false);
})(document);
