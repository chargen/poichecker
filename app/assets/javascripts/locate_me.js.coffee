#= require leaflet

$ ->
  onMarkerDrag = (e) ->
    $("#candidate_lat").val e.target._latlng.lat
    $("#candidate_lon").val e.target._latlng.lng
    return
  onMapClick = (e) ->
    $("#candidate_lat").val e.latlng.lat
    $("#candidate_lon").val e.latlng.lng
    marker.setLatLng e.latlng
    return

  if (el = $('#locate_map')).length > 0
    lat = $("#locate_map").data("lat")
    lon = $("#locate_map").data("lon")
    map = L.map("locate_map").setView([
      lat
      lon
    ], 16)
    tiles = L.tileLayer("http://{s}.tiles.mapbox.com/v3/sozialhelden.map-iqt6py1k/{z}/{x}/{y}.png64",
      attribution: "Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://opendatacommons.org/licenses/odbl/summary/\">ODbL</a>, Tiles © <a href=\"http://mapbox.com\">Mapbox</a>"
      maxZoom: 18
    ).addTo(map)
    circle = L.circle([
      lat
      lon
    ], 150,
      weight: 3
      color: '#BB2585'
      fillColor: "#BB2585"
      fillOpacity: 0.30
    ).addTo(map)
    markerIcon = L.icon(
      iconUrl: "http://api.tiles.mapbox.com/v3/marker/pin-l-star+008472.png"
      iconRetinaUrl: "http://api.tiles.mapbox.com/v3/marker/pin-l-star+a22@2x.png"
      iconSize: [
        36
        90
      ]
      popupAnchor: [
        -3
        -76
      ]
    )
    marker = L.marker([
      90.0
      0.0
    ],
      icon: markerIcon
      draggable: true
    ).addTo(map)
    map.attributionControl.setPrefix ""
    map.on "click", onMapClick
    marker.on "dragend", onMarkerDrag