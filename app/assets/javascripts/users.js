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
      
    })
  })
}
