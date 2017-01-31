<template>
  <a :href="post.url" class='item'>{{ post.title }}</a>
</template>

<script>
export default {
  name: 'relatedPosts',
  props: ['post']
}
</script>
