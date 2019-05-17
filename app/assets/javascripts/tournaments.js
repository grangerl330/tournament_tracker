$(function(){
  console.log('tournaments.js is loaded...')
  listenForClickTournamentsPage()
})

function listenForClickTournamentsPage() {
  onClickMatchLink()
  onClickShowAllMatches()
}

// function onClickAddMatch(){
//   $('#add-match').on('click', function(event){
//     event.preventDefault()
//
//     $.ajax({
//
//     })
//
//   })
// }

function onClickMatchLink(){
  $('.match-link').on('click', function(event){
    event.preventDefault()

    $.ajax({
      url: this.href,
      method: 'get',
      dataType: 'json'
    }).done(function(data){
      console.log("the data is: ", data)

      var match = new Match(data)
      match.convertRoundName()

      var matchHTML = match.singleMatchHTML()
      var showMatchesHref = match.showAllMatchesHref()

      $('#all-match-display').attr("style", "display:none")
      $('#single-match-display').html(matchHTML)

      editShowAllMatchesLink(showMatchesHref)
    })
  })
}

function onClickShowAllMatches() {
  $('#show-matches-link').on('click', function(event){
    event.preventDefault()

    $.ajax({
      url: this.href,
      method: 'get',
      dataType: 'json'
    }).done(function(data){
      console.log("the data is: ", data)

      $('#all-match-display').attr("style", "")
      $('#show-matches-link').attr("style", "display:none")
      $('#single-match-display').html("")
    })
  })
}

function editShowAllMatchesLink(href){
  $('#show-matches-link').attr("href", href)
  $('#show-matches-link').attr("style", "")
  $('#show-matches-link').text("Show All Matches")
}

class Match {
  constructor(obj){
    this.date = obj.date
    this.id = obj.id
    this.score = obj.score
    this.time = obj.time
    this.tournament = obj.tournament
    this.won = obj.won
    this.round = obj.round
    this.opponent = obj.opponent
  }
}

Match.prototype.convertRoundName = function() {
  if (this.round === 8) {
    this.round = "Quarter-Final"
  } else if (this.round === 4) {
    this.round = "Semi-Final"
  } else if (this.round === 2) {
    this.round = "Final"
  } else {
    this.round
  }
}

Match.prototype.singleMatchHTML = function() {
  return(`
    <h2>${this.round}</h2>
    <p><b>vs:</b> ${this.opponent.first_name} ${this.opponent.last_name}</p>
    <p><b>Date:</b> ${this.date}</p>
    <p><b>Time:</b> ${this.time}</p>
    <p><b>Score:</b> ${this.score}</p>
  `)
}

Match.prototype.showAllMatchesHref = function(){
  return (`http://localhost:3000/tournaments/${this.tournament.id}`)
}
