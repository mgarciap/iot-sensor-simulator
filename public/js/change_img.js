var i = 0;
var value = 100;
function changeImg () {
  i++;

  if(i < 9) {
    $('#beer_img').attr('src','/img/beer_00' + i + '.png');
    $.post("publish/" + "sensor/" + value, function(data) {
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

  if(i == 1) {
    value -= 16;
  }
  else {
    value -= 14;
  }
}

function firstImg () {
  i = 0;
  value = 100;
  changeImg();
}

$(document).ready(function() {
  $("#minus").click(changeImg);
  $("#plus").click(firstImg);
});

changeImg();
