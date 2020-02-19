<template>
  <div>
    <p>Description</p>
    <p class="lead small line-height-2">
      {{ displayText }}
      <a class="in-gold-500 ml-10" href="" v-if="text.length > sizeN" @click.prevent="updateText">{{ buttonText }}</a>
    </p>
  </div>
</template>


<script>
  export default {
    props: {
      text: {
        type: String,
        default: ''
      },
      size: {
        type: String,
        default: '500'
      }
    },
    data: function () {
      return {
        displayText: this.text.substring(0, this.size),
        sizeN: Number(this.size),
        isTextCutted: false,
        buttonText: 'Read more'
      }
    },
    mounted: function () {
      if (this.text.length > this.sizeN) {
        this.cutText()
      }
    },
    methods: {
      updateText() {
        this.isTextCutted ? this.unCutText() : this.cutText()
      },

      cutText() {
        this.displayText = `${this.text.substring(0, this.sizeN - 50).trim()}...`
        this.buttonText = 'Read more'
        this.isTextCutted = true
      },

      unCutText() {
        this.displayText = this.text
        this.buttonText = 'Read less'
        this.isTextCutted = false
      }
    }
  }
</script>
