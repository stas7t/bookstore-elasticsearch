<template>
  <div>
    <a class="input-link pt-7" href="" @click.prevent="decrementValue">
      <i class="fa fa-minus line-height-40" aria-hidden="true"></i>
    </a>
    <input
      v-model="newValue"
      :class="field_class"
      :id="field_id"
      :name="field_name"
      type="text"
    >
    <a class="input-link pt-7" href="" @click.prevent="incrementValue">
      <i class="fa fa-plus line-height-40" aria-hidden="true"></i>
    </a>
  </div>
</template>

<script>
  export default {
    props: {
      field_id: String,
      field_name: String,
      field_class: String,
      value: String
    },
    data: function () {
      return {
        newValue: Number(this.value),
      }
    },
    methods: {
      incrementValue() {
        this.newValue += 1
      },
      decrementValue() {
        if (this.newValue > 0) {
          this.newValue -= 1
        }
      }
    }
  }
</script>
