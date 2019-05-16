$(function(){
  console.log('users.js is loaded...')
  listenForClick()
})

function listenForClick() {
  $('button#tournaments-data').on('click', function(event) {
    event.preventDefault()
    // alert("You Clicked The Link")
    $.ajax({
      url: `http://localhost:3000/users/${this.value}/tournaments`,
      method: 'get',
      dataType: 'json'
    }).done(function(data){
      console.log("the data is: ", data)

      let tournament = new Tournament(data[0])
      let tournamentHTML = tournament.tournamentHTML()

      $('#show-tournaments').append(tournamentHTML)
    })
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

Tournament.prototype.tournamentHTML = function() {
  return(`

    <h2>Tournaments</h2>

    <h4>${this.title}</h4>
    `)
}
