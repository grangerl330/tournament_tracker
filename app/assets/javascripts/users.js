$(function(){
  console.log('users.js is loaded...')
  listenForClick()
})

function listenForClick() {
  $('button#tournaments-data').on('click', function(event) {
    event.preventDefault()

    if($('button#tournaments-data').text() === "Show Tournaments"){
      $.ajax({
        url: `http://localhost:3000/users/${this.value}/tournaments`,
        method: 'get',
        dataType: 'json'
      }).done(function(data){
        console.log("the data is: ", data)

        var tournamentsHTML = tournamentsListHTML(data)
        $('#show-tournaments').html("")
        $('#show-tournaments').append(tournamentsHTML)
        $('button#tournaments-data').text("Hide Tournaments")
      })
    } else {
      $('#show-tournaments').html("")
      $('button#tournaments-data').text("Show Tournaments")
    }
  })
}

class Tournament {
  constructor(obj){
    this.id = obj.id
    this.title = obj.title
    this.draw_size = obj.draw_size
    this.location = obj.location
    this.start_date = obj.start_date
    this.end_date = obj.end_date
    this.points = obj.points
    this.won = obj.won
    this.matches = obj.matches
  }
}

function tournamentsListHTML(data) {
  var counter = 1

  var html = `
    <h3>Tournaments</h3>
    <ul>
  `

  data.forEach(function(tournament_data){
    var tournament = new Tournament(tournament_data)

    html += `<li>${counter}. ${tournament.tournamentHTML()}</li>`
    counter += 1
  })

  html += `</ul>`

  return(html)
}

Tournament.prototype.tournamentHTML = function() {
  return(`${this.title}`)
}
