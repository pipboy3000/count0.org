import 'babel-polyfill';
import hljs from 'highlight.js';
import _ from 'lodash';
import React from 'react';
import { render } from 'react-dom';
import RelatedPosts from './components/related-posts';

// shorthand
var q = (selector) => document.querySelector(selector)
var qa = (selector) => document.querySelectorAll(selector);

// highlight.js
hljs.initHighlightingOnLoad();

// mobile header transform 
window.addEventListener('scroll', (e) => {
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
}, false);

// related posts
var related_posts_mount = q('.related-posts-container');
if (related_posts_mount) {
  var categories = _.map(qa('.meta .category'), item => item.innerText);
  render(<RelatedPosts categories={categories} />, related_posts_mount);
}

