$(function(){
  console.log('users.js is loaded...')
  listenForClick()
})

function listenForClick() {
  $('#tournaments-data').on('click', function(event) {
    event.preventDefault()

    if($('#tournaments-data').text() === "Show Tournaments"){
      $.ajax({
        url: this.href,
        method: 'get',
        dataType: 'json'
      }).done(function(data){
        console.log("the data is: ", data)

        var tournamentsHTML = tournamentsListHTML(data)
        $('#show-tournaments').html("")
        $('#show-tournaments').append(tournamentsHTML)
        $('#tournaments-data').text("Hide Tournaments")
      })
    } else {
      $('#show-tournaments').html("")
      $('#tournaments-data').text("Show Tournaments")
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
    this.user = obj.user
  }
}

function tournamentsListHTML(data) {
  var counter = 1

  var html = `
    <h3 class="inline">Tournaments</h3><a href='http://localhost:3000/users/${data[0].user.id}/tournaments/new'>Add Tournament</a>
    <ul>
  `

  data.forEach(function(tournament_data){
    var tournament = new Tournament(tournament_data)

    html += `<li>${counter}. <a href='http://localhost:3000/tournaments/${tournament.id}'>${tournament.tournamentHTML()}</a></li>`
    counter += 1
  })

  html += `</ul>`

  return(html)
}

Tournament.prototype.tournamentHTML = function() {
  return(`${this.title}`)
}
