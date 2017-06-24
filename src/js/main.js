import 'babel-polyfill';
import hljs from 'highlight.js';
import Vue from 'vue';
import mobileHeader from './mobileHeader'
import '../scss/style.scss';

// highlight.js
hljs.initHighlightingOnLoad();

// mobile header transform 
mobileHeader()

// Vue
import RelatedPosts from './components/RelatedPosts.vue'

new Vue({
  el: '#related-posts',
  components: {
    RelatedPosts
  },
  template: '<RelatedPosts></RelatedPosts>'
});