$.get('/api/routes_all').then(function(data) {

  console.log(data)

})

function processRequests(){
  console.log("Processing requests");
  //Counter to track request submission;
  var cur = 0;
  if(renderArray.length > 0){
    for(var r=0; r < renderArray.length; r++){
      console.log(r);
      renderArray[r].setMap(null);
    }
  }
  submitRequest();
  function nextRequest(){
    cur++;
    if(cur >= requestArray.length){
      console.log("Done");
      return;
    }
    submitRequest();
  }
  function submitRequest(){
    console.log("Submitting request for: ", requestArray[cur].requestID);
    directionsService.route(requestArray[cur].request, directionResults);
  }
  /*
  *  Callback function provided to the Maps API Direction Service. It creates
  *  a new DirectionsRenderer to manage the new route without overriding the
  *  old route
  *
  *  @param result - the route information
  *  @param status - Success or Fail
  */
  function directionResults(result, status) {
    console.log("Receiving request for route: ", cur);
    if (status == google.maps.DirectionsStatus.OK) {
      renderArray[cur] = new google.maps.DirectionsRenderer();
      renderArray[cur].setMap(map);
      renderArray[cur].setDirections(result);
    }
    nextRequest();
  }
}