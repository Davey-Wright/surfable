// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require foundation
//= confirmation_modal

$(document).on('turbolinks:load', function() {
  $(document).foundation().confirmWithReveal();
});


let open_modal = function(content, callback){
  let $modal = $('#modal'),
      $modal_content = $('.modal_content');

  $($modal_content).html(content).promise().done(function(){
    $modal.foundation('open');
  })

  $modal.on('closed.zf.reveal', function(e){
    $($modal_content).html('');
  });

  if (typeof callback === "function") {
    $modal.on('open.zf.reveal', callback());
  }
}


let close_modal_and_redirect = function(url){
  setTimeout(function() {
    $('#modal').foundation('close');
  }, 2000);

  $('#modal').on('closed.zf.reveal', function(){
    window.location.replace(url);
  });
}




function initSpotIndexMap(spots) {
  var lat = '51.4790',
      lng = '-3.7052';
  var myCoords = new google.maps.LatLng(lat, lng);

  var mapOptions = {
    center: myCoords,
    zoom: 10,
    mapTypeId: 'satellite',
    disableDefaultUI: true,
    zoomControl: true,
    fullscreenControl: true
  };

  var infowindow = new google.maps.InfoWindow();
  var map = new google.maps.Map(document.getElementById('spot_index_map'), mapOptions);

  for(var i = 0; i < spots.length; i++){
    var spot = spots[i];
    var lat = (Math.round(parseFloat(spot[0])*1000000))/1000000;
    var lng = (Math.round(parseFloat(spot[1])*1000000))/1000000;

    var marker = new google.maps.Marker({
      position: {lat: lat, lng: lng},
      map: map
    })

    marker.addListener('click', function(){
      infowindow.close();
      infowindow.setContent( "<div id='infowindow'> Melaka Broo </div>");
      infowindow.open(map, this);
    });
  }
}




function initSpotShowMap(lat, lng) {
  var myCoords = new google.maps.LatLng(lat, lng);

  var mapOptions = {
    center: myCoords,
    zoom: 14,
    mapTypeId: 'satellite',
    disableDefaultUI: true,
    zoomControl: true,
    fullscreenControl: true
  };

  var map = new google.maps.Map(document.getElementById('spot_show_map'), mapOptions);

  var marker = new google.maps.Marker({
        position: myCoords,
        map: map
  });
}

function initSpotNewMap() {
  var lat = document.getElementById('spot_latitude').value,
      lng = document.getElementById('spot_longitude').value;

  if(!lat || !lng){
    lat = '51.4790';
    lng = '-3.7052';
    document.getElementById('spot_latitude').value = lat;
    document.getElementById('spot_longitude').value = lng;
  }

  var myCoords = new google.maps.LatLng(lat, lng);

  var mapOptions = {
    center: myCoords,
    zoom: 11,
    mapTypeId: 'satellite',
    disableDefaultUI: true,
    zoomControl: true,
    fullscreenControl: true
  };

  var map = new google.maps.Map(document.getElementById('spot_new_map'), mapOptions);

  var marker = new google.maps.Marker({
        position: myCoords,
        animation: google.maps.Animation.DROP,
        map: map,
        draggable: true
  });

  function refreshMarker(){
    console.log('change')
    var lat = document.getElementById('spot_latitude').value,
        lng = document.getElementById('spot_longitude').value;
    var myCoords = new google.maps.LatLng(lat, lng);
    marker.setPosition(myCoords);
    map.setCenter(marker.getPosition());
  };

  // marker change listeners
  document.getElementById('spot_latitude').onchange = refreshMarker;
  document.getElementById('spot_longitude').onchange = refreshMarker;

  // when marker is dragged update input values
  marker.addListener('drag', function() {
      latlng = marker.getPosition();
      newlat=(Math.round(latlng.lat()*1000000))/1000000;
      newlng=(Math.round(latlng.lng()*1000000))/1000000;
      document.getElementById('spot_latitude').value = newlat;
      document.getElementById('spot_longitude').value = newlng;
  });

  // When drag ends, center (pan) the map on the marker position
  marker.addListener('dragend', function() {
      map.panTo(marker.getPosition());
  });

}
