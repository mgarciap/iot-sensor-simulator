function updateTemp(delta) {
  var $temp = document.getElementById('temp');
  var temp = parseInt($temp.innerHTML, 10);
  temp += delta;
  $temp.innerHTML = temp;
  $.post("publish/" + "temperature/" + temp, function(data) {
    var response = JSON.parse(data);
    response.forEach(function(item) {
      $('#logs ul').append('<li>'+item+'</li>');
    });
    var elem = document.getElementById('logs-list');
    elem.scrollTop = elem.scrollHeight;
  });
}
