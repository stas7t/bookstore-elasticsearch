# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.search-nav-input').on 'paste keyup', (event) ->
    $('.search-results ul li').remove()
    query = $(this).val()
    limit = 5

    if window.location.pathname == '/catalog' || window.location.pathname == '/books'
      return if event.keyCode != 13

      url_search_params = window.location.search.replace('?', '').split('&')
      search_params = {}

      $.each url_search_params, (i, value) ->
        search_params["#{value.split('=')[0]}"] = value.split('=')[1]

      search_params['q'] = query

      new_search_params = $.map search_params, (value, key) ->
        "#{key}=#{value}"

      window.location.search = "?#{new_search_params.join('&')}"
    else
      return if query.length < 3

      $.ajax(
        url: "/search.json?q=#{query}&limit=#{limit}"
        context: document.body).done (result) ->
          $.each result, (index, value) ->
            $('.search-results ul').append("<li><a href='/books/#{value._source.id}'>#{value._source.title}</a></li>")
            return
          $('.search-results ul').append("<li><a href='/catalog?q=#{query}' class='ml-60 in-gold-500'>View all</a></li>") unless result.length < 5
        return

    return
