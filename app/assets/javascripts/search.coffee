# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.search-nav-input').on 'paste keyup', ->
    $('.search-results ul li').remove()
    query = $(this).val()
    limit = 5
    return if query.length < 3

    $.ajax(
      url: "/search.json?q=#{query}&limit=#{limit}"
      context: document.body).done (result)->
      $.each result, (index, value) ->
        # console.log(value._source)
        $('.search-results ul').append("<li>#{value._source.title}</li>")
        return
      return

    return
