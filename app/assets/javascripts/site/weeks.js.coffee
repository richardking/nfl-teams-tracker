$ ->
  $("span.locked a").on 'click', (e)->
    e.preventDefault()
    alert("Game has started; team is locked!")
    return false