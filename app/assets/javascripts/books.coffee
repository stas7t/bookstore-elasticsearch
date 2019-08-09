# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  content = $('p.lead.small.line-height-2').html()
  $('p.lead.small.line-height-2').each ->
    if content.length > 500
      shortContent = content.substr(0, 470).trim() + "..."
      $(this).html shortContent + "<a class='in-gold-500 ml-10' id='read_more' href='#'>Read more<a/>"

  $('#read_more').click ->
    $('p.lead.small.line-height-2').each ->
      $(this).html content + "<a class='in-gold-500 ml-10' id='read_less' href=''>Read less<a/>"
      $('#read_more').hide()
    false

  $('#read_less').click ->
    $('p.lead.small.line-height-2').each ->
      $(this).html shortContent + "<a class='in-gold-500 ml-10' id='read_more' href=''>Read more<a/>"
    false
