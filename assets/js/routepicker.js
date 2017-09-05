      // This example requires the Places library. Include the libraries=places
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">
var route = {};
var directionsInfo;

var start = document.getElementById('start');
var end = document.getElementById('end');
var waypoints = document.getElementById('waypoints');
var originInput = document.getElementById('origin-input');
var destinationInput = document.getElementById('destination-input');

function initPickerMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    mapTypeControl: false,
    center: {lat: 51.5074, lng: 0.1278},
    zoom: 3
  });
  new AutocompleteDirectionsHandler(map);
}

 /**
  * @constructor
 */
function AutocompleteDirectionsHandler(map) {
  this.map = map;
  this.originPlaceId = null;
  this.destinationPlaceId = null;
  this.travelMode = 'BICYCLING'

  this.directionsService = new google.maps.DirectionsService;
  this.directionsService.route({'travelMode': google.maps.DirectionsTravelMode.BICYCLING})

  this.directionsDisplay = new google.maps.DirectionsRenderer({'draggable':true});
  this.directionsDisplay.setMap(map);
  directionsInfo = this.directionsDisplay;

  var originAutocomplete = new google.maps.places.Autocomplete(
      originInput, {placeIdOnly: true});
  var destinationAutocomplete = new google.maps.places.Autocomplete(
      destinationInput, {placeIdOnly: true});

  this.setupPlaceChangedListener(originAutocomplete, 'ORIG');
  this.setupPlaceChangedListener(destinationAutocomplete, 'DEST');
  this.directionsDisplay.addListener('directions_changed', function() {
    saveRoute(directionsInfo)
  })

  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(originInput);
  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(destinationInput);
}

AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(autocomplete, mode) {
  var me = this;
  autocomplete.bindTo('bounds', this.map);
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.place_id) {
      window.alert("Please select an option from the dropdown list.");
      return;
    }
    if (mode === 'ORIG') {
      me.originPlaceId = place.place_id;
    } else {
      me.destinationPlaceId = place.place_id;
    }
    me.route();
  });
};

AutocompleteDirectionsHandler.prototype.route = function() {
  if (!this.originPlaceId || !this.destinationPlaceId) {
    return;
  }
  var me = this;
  this.directionsService.route({
    origin: {'placeId': this.originPlaceId},
    destination: {'placeId': this.destinationPlaceId},
    travelMode: this.travelMode
  }, function(response, status) {
    if (status === 'OK') {
      me.directionsDisplay.setDirections(response);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
};

var saveRoute = function (directionsDisplay) {
    var final_waypoints={}, via;
    var route_legs = directionsDisplay.directions.routes[0].legs[0];
    if(!route_legs) {
      return
    }
    route.start = {'type': 'Point', 'coordinates': [route_legs.start_location.lng(), route_legs.start_location.lat()]}
    route.end = {'type': 'Point', 'coordinates': [route_legs.end_location.lng(), route_legs.end_location.lat()]}
    var via = route_legs.via_waypoints 

    for(var i=0;i<via.length;i++) {
      final_waypoints[''+i+''] = {'type': 'Point', 'coordinates': [via[i].lng(), via[i].lat()]}
    }

    route.waypoints = final_waypoints; 
    start_name.value = originInput.value
    end_name.value = destinationInput.value
    
    waypoints.value = JSON.stringify(route.waypoints)
    start.value = JSON.stringify(route.start)
    end.value = JSON.stringify(route.end)
}