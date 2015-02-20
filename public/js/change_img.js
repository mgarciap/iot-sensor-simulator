var i = 0;
function changeImg () {
  i++;

  if(i < 9) {
    $('#beer_img').attr('src','/img/beer_00' + i + '.png');
    $.post("publish/" + "sensor/" + sensor, function(data) {
      var response = JSON.parse(data);
      response.forEach(function(item) {
        $('#logs ul').append('<li>'+item+'</li>');
      });
      var elem = document.getElementById('logs-list');
      elem.scrollTop = elem.scrollHeight;
    });
  }
  else {
    $('#error_msg').show();
  }
}

function firstImg () {
  i = 0;
  changeImg();
}

$(document).ready(function() {
  $("#minus").click(changeImg);
  $("#plus").click(firstImg);
});

changeImg();
