    var coords = document.getElementById('coords')
    var start_point = JSON.parse(coords.getAttribute('data-start'));
    var end_point = JSON.parse(coords.getAttribute('data-end'));
    var start_lng = start_point.coordinates[0];
    var start_lat = start_point.coordinates[1];
    var end_lng = end_point.coordinates[0];
    var end_lat = end_point.coordinates[1];

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            mapTypeControl: false,
            zoom: 3
        });
        displayRoute();
    }


    function displayRoute() {
        var start = new google.maps.LatLng(start_lat, start_lng);
        var end = new google.maps.LatLng(end_lat, end_lng);

        var directionsDisplay = new google.maps.DirectionsRenderer();// also, constructor can get "DirectionsRendererOptions" object
        directionsDisplay.setMap(map); // map should be already initialized.

        var request = {
            origin : start,
            destination : end,
            travelMode : google.maps.TravelMode.BICYCLING
        };

        var directionsService = new google.maps.DirectionsService(); 
        directionsService.route(request, function(response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response);
            }
        });
    }
