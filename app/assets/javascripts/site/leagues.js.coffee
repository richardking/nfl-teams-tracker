$ ->
  $('.show_all').on 'click', (e)->
    (e).preventDefault()
    $('.league_header').toggle()
    $('tr.all:not(.current_user)').toggle()
    $('.show_all').toggle()


  $('.test_json_scores').on 'click', (e)->
    (e).preventDefault()
    $.ajax
      url: "http://www.nfl.com/liveupdate/scorestrip/scorestrip.json"
      type: 'get'
      success: (data, textStatus, jqXHR)->
        html = data.responseText
        parse = eval(html.substring(html.indexOf("<p>") + 9, html.indexOf("}</p>")))
        console.log data.responseText
        console.log parse
        console.log "success"