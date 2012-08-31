$ ->
  $('.show_all').on 'click', ->
    $('.league_header').toggle()
    $('tr.all:not(.current_user)').toggle()
    $('.show_all').toggle()