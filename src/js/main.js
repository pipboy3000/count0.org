import 'babel-polyfill';
import Vue from 'vue';
import mobileHeader from './mobileHeader'
import '../scss/style.scss';

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
