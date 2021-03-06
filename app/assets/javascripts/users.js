$(function(){
  console.log('users.js is loaded...')
  listenForClickUsersPage()
})

function listenForClickUsersPage() {
  onClickShowTournaments()
  onClickShowStyleTags()
  onClickShowPreviousOpponents()
}

function onClickShowTournaments(){
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
        $('#show-data').html("")
        $('#show-data').append(tournamentsHTML)
        $('#tournaments-data').text("Hide Tournaments")
        updateLinks("keep tournaments")
      })
    } else {
      $('#show-data').html("")
      $('#tournaments-data').text("Show Tournaments")
      updateLinks("restore links")
    }
  })
}

function onClickShowStyleTags(){
  $('#style-tags-data').on('click', function(event){
    event.preventDefault()

    if($('#style-tags-data').text() === "Show Style Tags"){
      $.ajax({
        url: this.href,
        method: 'get',
        dataType: 'json'
      }).done(function(data){
        console.log("the data is: ", data)

        var styleTagsHTML = styleTagsListHTML(data)
        $('#show-data').html("")
        $('#show-data').append(styleTagsHTML)
        $('#style-tags-data').text("Hide Style Tags")
        updateLinks("keep style tags")
      })
    } else {
      $('#show-data').html("")
      $('#style-tags-data').text("Show Style Tags")
      updateLinks("restore links")
    }
  })
}

function onClickShowPreviousOpponents() {
  $('#opponents-data').on('click', function(event){
    event.preventDefault()

    if($('#opponents-data').text() === "Show Previous Opponents"){
      $.ajax({
        url: this.href,
        method: 'get',
        dataType: 'json'
      }).done(function(data){
        console.log("the data is: ", data)

        var opponentsHTML = opponentsListHTML(data)
        $('#show-data').html("")
        $('#show-data').append(opponentsHTML)
        $('#opponents-data').text("Hide Previous Opponents")
        updateLinks("keep opponents")
      })
    } else {
      $('#show-data').html("")
      $('#opponents-data').text("Show Previous Opponents")
      updateLinks("restore links")
    }
  })
}

function updateLinks(keyword){
  if (keyword === "keep tournaments") {
    $('#style-tags-data').text("")
    $('#opponents-data').text("")
  } else if (keyword === "keep style tags") {
    $('#tournaments-data').text("")
    $('#opponents-data').text("")
  } else if (keyword === "restore links"){
    restoreLinks()
  } else {
    $('#tournaments-data').text("")
    $('#style-tags-data').text("")
  }
}

function restoreLinks(){
  $('#tournaments-data').text("Show Tournaments")
  $('#style-tags-data').text("Show Style Tags")
  $('#opponents-data').text("Show Previous Opponents")
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

Tournament.prototype.tournamentHTML = function() {
  return(`${this.title}`)
}

class Opponent {
  constructor(obj){
    this.id = obj.id
    this.first_name = obj.first_name
    this.last_name = obj.last_name
    this.age = obj.age
    this.handedness = obj.handedness
    this.match_id = obj.match_id
  }
}

Opponent.prototype.opponentHTML = function() {
  return(`${this.first_name} ${this.last_name}`)
}

function opponentsListHTML(data) {
  var counter = 1

  var html = `
    <h3>Opponents</h3>
    <ul>
  `

  data.forEach(function(opponent_data){
    var opponent = new Opponent(opponent_data)

    html += `<li>${counter}. <a href='http://localhost:3000/opponents/${opponent.id}'>${opponent.opponentHTML()}</a></li>`
    counter += 1
  })

  html += `</ul>`

  return(html)
}

function tournamentsListHTML(data) {
  var counter = 1

if(data[0] !== undefined){
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

} else {
  var html = `<h3 class="inline">Tournaments</h3><a href='http://localhost:3000/tournaments/new'>Add Tournament</a>`
}

  return(html)
}

function styleTagsListHTML(data) {
  var html = `
    <h3 class="inline">Style Tags</h3><a href='http://localhost:3000/style_tags/new'>Add Style Tag</a>
    <ul>
  `

  data.forEach(function(styleTagData){
    html += `
      <li>
        ${styleTagData.name}
        <a class="small" href="/style_tags/${styleTagData.id}/edit">Edit</a>
        <a class="small" rel="nofollow" data-method="delete" href="/style_tags/${styleTagData.id}">Delete</a>
      </li>
    `
  })

  html += '</ul>'

  return(html)
}
