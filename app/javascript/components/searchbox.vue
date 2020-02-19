<template>
  <div>
    <div class="text-center">
      <input
        v-model="query"
        class="searchbox-main"
        id="q"
        name="q"
        type="text"
        placeholder="Find а book"
        @input="getSearchResults"
        @keyup.enter="applyUrlSearch"
      >
    </div>
    <div class="search-results" v-if="isSearchResultsMode && query.length >= 3">
      <ul style="list-style-type: none;">
          <li v-for="item in searchResults" :key="item._source.id">
            <a :href="`/books/${item._source.id}`">{{ item._source.title }}</a>
          </li>
          <li v-if="searchResults.length == limit"><a :href="`/catalog?q=${query}`" class="ml-60 in-gold-500">View all</a></li>
          <li v-if="searchResults.length == 0"><span>{{ `'${query}' not found` }}</span></li>
      </ul>
    </div>
  </div>
</template>

<script>
  import axios from "axios";

  export default {
    props: {
      mode: String
    },
    data: function () {
      return {
        query: '',
        isSearchResultsMode: this.mode == 'search-results',
        isReloadPageMode: this.mode == 'reload-page',
        limit: 5,
        searchResults: [],
        urlSearchParams: [],
        searchParams: {},
        newSearchParams: []
      }
    },
    mounted: function () {
      if (this.isReloadPageMode && !!window.location.search) {
        this.urlSearchParams = window.location.search.replace('?', '').split('&')
        this.urlSearchParams.forEach( element => this.searchParams[`${element.split('=')[0]}`] = element.split('=')[1] )
        this.query = !!this.searchParams['q'] ? decodeURI(this.searchParams['q']) : ''
      }
    },
    methods: {
      getSearchResults() {
        if (!this.isSearchResultsMode || this.query.length < 3) { return }
        axios.get(`/search.json?q=${this.query}&limit=${this.limit}`)
          .then(response => this.searchResults = response.data)
      },
      applyUrlSearch() {
        if (!this.isReloadPageMode || this.query.length < 3) { return }

        this.searchParams['q'] = this.query
        this.newSearchParams = Object.keys(this.searchParams).map(key => `${key}=${this.searchParams[key]}`)

        window.location.search = `?${this.newSearchParams.join('&')}`
      }
    }
  }
</script>
