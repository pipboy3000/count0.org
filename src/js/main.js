import 'babel-polyfill';
import hljs from 'highlight.js';
import _ from 'lodash';
import Vue from 'vue';
import '../scss/style.scss';
import axios from 'axios';

// shorthand
const q = (selector) => document.querySelector(selector)
const qa = (selector) => document.querySelectorAll(selector);

// highlight.js
hljs.initHighlightingOnLoad();

// mobile header transform 
window.addEventListener('scroll', (e) => {
  const header = q('.layout-document > .header');
  const header_height = getComputedStyle(header).height.split('px')[0];

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
import RelatedPosts from './components/related-posts.vue'
Vue.component('related-posts', RelatedPosts);

Vue.component('related-posts-item', {
  template: '<a href="">item</a>'
});

new Vue({
  el: '#related-posts',
  data: {
    categories: [],
    posts: []
  },
  created: function() {
    this.categories = _.map(qa('.meta .category'), item => item.innerText);
    Promise.all(this.categories.map(category => getJSON(category)))
            .then(results => {
              const all_posts =  _.uniqBy(_.flatten(results), 'id');
              const sorted = _.sortBy(all_posts, post => Date.parse(post.date)).reverse();
              this.posts = sorted;
            })
            .catch(err => console.error(err));
    
  }
}).$mount('#related-posts');

function getJSON(category) {
  return new Promise((resolve, reject) => {
    axios.get(`/categories/${category}/index.json`)
          .then((res) => {
            resolve(res.data);
          })
          .catch((err) => {
            console.error(err);
          });
  });
}

