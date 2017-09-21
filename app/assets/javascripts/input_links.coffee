$(document).on 'turbolinks:load', ->
  $('.fa-minus').parent('a').click (event) ->
    event.preventDefault()
    input_el = $(this).siblings('.quantity-input')
    quantity = +input_el.val()
    if quantity > 1
      input_el.val(quantity - 1)

  $('.fa-plus').parent('a').click (event) ->
    event.preventDefault()
    input_el = $(this).siblings('.quantity-input')
    quantity = +input_el.val()
    input_el.val(quantity + 1)
