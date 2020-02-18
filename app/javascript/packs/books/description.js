import Vue from 'vue/dist/vue.esm'
import Description from '../../components/books/description.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#description',
    components: { Description }
  })
})
