$ ->
  $('.parse_espn').on 'click', (e)->
    e.preventDefault()
    $.ajax
      url: 'http://api.espn.com/v1/sports/football/nfl/teams\?apikey\=gk9n3uhx7cbgwx85vq3frxsz'
      dataType: 'jsonp'
      success: (data, textStatus, jqXHR)->
        console.log data
        teams = data.sports[0].leagues[0].teams
        console.log teams
        $.each teams, (key,val)->
          console.log val.abbreviation
          console.log val.color
          console.log val.location
          console.log val.name
          $('<li>' + val.abbreviation + ',' + val.color + ',' + val.location + ',' + val.name + '</li>').appendTo('.placeholder')
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(jqXHR)
        console.log(textStatus)
        console.log(errorThrown)
