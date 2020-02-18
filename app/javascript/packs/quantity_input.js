import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import QuantityInput from '../components/quantity_input.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#quantity-input',
    components: { QuantityInput }
  })
})
