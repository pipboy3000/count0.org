<template>
  <div class="related-posts">
    <h3 class='header'>関連記事一覧</h3>
    <div class='item' v-for='post in posts' :key='post.url'>
      <a :href="post.url" class='link'>{{ post.title }}</a>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import _ from 'lodash'
import { qa } from '../dom.js'

function getCategoryJSON(category) {
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

function categoriesFromPost() {
  return _.map(qa('.meta .category'), item => item.innerText);
}

export default {
  name: 'relatedPosts',
  props: {
    num: {
      default: 10,
      type: Number
    }
  },
  data: function () {
    return {
      categories: [],
      posts: []
    }
  },
  created: function () {
    this.categories = categoriesFromPost()

    Promise.all(this.categories.map(category => getCategoryJSON(category)))
      .then(results => {
        const all_posts = _.uniqBy(_.flatten(results), 'id');
        const sorted_posts = _.sortBy(all_posts, post => Date.parse(post.date)).reverse();
        const posts = _.take(sorted_posts, this.num)
        this.posts = posts;
      })
      .catch(err => console.error(err));
  }
}
</script>

<style lang="scss" scoped>
.header {
  border-top: 1px solid rgba(black, 0.3);
  font-size: 18px;
  padding-top: 2rem;
  padding-bottom: 2rem;
  margin: 0;
}

.item {
  padding-left: 1rem;
}

.link {
  display: block;
  margin-bottom: 1rem;
}
</style>

