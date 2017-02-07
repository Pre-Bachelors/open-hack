<!doctype html>
<html class="no-js" lang="">
  <head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Tour Here</title>

    <link rel="apple-touch-icon" href="apple-touch-icon.png">
    <!-- Place favicon.ico in the root directory -->

    <!-- build:css styles/vendor.css -->
    <!-- bower:css -->
    <!-- endbower -->
    <!-- endbuild -->

    <!-- build:css styles/main.css -->
    <link rel="stylesheet" href="styles/main.css">
    <!-- endbuild -->

    <!-- build:js scripts/vendor/modernizr.js -->
    <script src="/bower_components/modernizr/modernizr.js"></script>
    <!-- endbuild -->


    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js" charset="utf-8"></script>

  </head>
  <body>
    <!--[if IE]>
      <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->

    <div class="container">
      <div class="header">
        <ul class="nav nav-pills float-right">
          <li class="nav-item">
            <a class="nav-link" style="color:#6685a0" href="/">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="journey.html">Log In</a>
          </li>
          <li class="nav-item">
            <a class="nav-link btn btn-primary" href="#">Sign Up</a>
          </li>
        </ul>
        <h3 class="text-muted">Tour Here</h3>
      </div>


      <div id="lisbonMap"></div>
<%

%>
      <script>
      $.getJSON("http://222.92.146.245:5066/rating/balancemgmt/v1/balance?identityNumber=35118815503333", function(data) {
        console.log(data);
      });



      function initMap() {
        var styledMapType = new google.maps.StyledMapType([
    {
        "featureType": "administrative",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            },
            {
                "gamma": "1.53"
            }
        ]
    },
    {
        "featureType": "administrative.land_parcel",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "landscape.man_made",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "simplified"
            },
            {
                "lightness": 20
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
            {
                "hue": "#f49935"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
            {
                "hue": "#fad959"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "hue": "#a1cdfc"
            },
            {
                "saturation": 30
            },
            {
                "lightness": 49
            }
        ]
    }
], {name: 'Styled Map'});

        var map = new google.maps.Map(document.getElementById('lisbonMap'), {
            center:new google.maps.LatLng(38.7223,-9.1393),
            zoom:13,
            mapTypeControlOptions: {
            mapTypeIds: ['roadmap', 'satellite', 'hybrid', 'terrain',
                    'styled_map']
          }
        });

        map.mapTypes.set('styled_map', styledMapType);
        map.setMapTypeId('styled_map');

        setMarkers(map);

        $.getJSON("http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productOffering?category.id=2353&fields=id,name,description,productOfferingPrice.price,productOfferingPrice.name,productSpecification", function(data) {
          $.each(data, function(i, item){
              $.getJSON("http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productSpecification?id="+item.productSpecification.id+"&fields=id,href,description,relatedParty", function(subData) {
                $.each(subData, function(i, subItem){
                  $.getJSON("http://env-0693795.jelastic.servint.net/DSPartyManagement/api/partyManagement/v2/organization?id="+subItem.relatedParty[0].id+"&fields=id,href,characteristic", function(endData) {
                    var coords = endData[0].characteristic.value.trim().split(',');
                    addMarkers(map, 'cafe', [
                      [item.name, Number(coords[0]), Number(coords[1]), (item.productOfferingPrice[0].price.taxIncludedAmount/100)]
                    ]);
                  });
                });
              });
          });
        });

        $.getJSON( "http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productOffering?category.id=2305&fields=id,name,description,productOfferingPrice.price,productOfferingPrice.name,productSpecification", function(data) {
          $.each(data, function(i, item){
              $.getJSON("http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productSpecification?id="+item.productSpecification.id+"&fields=id,href,description,relatedParty", function(subData) {
                $.each(subData, function(i, subItem){
                  $.getJSON("http://env-0693795.jelastic.servint.net/DSPartyManagement/api/partyManagement/v2/organization?id="+subItem.relatedParty[0].id+"&fields=id,href,characteristic", function(endData) {
                    var coords = endData[0].characteristic.value.trim().split(',');
                    addMarkers(map, 'viewpoint', [
                      [item.name, Number(coords[0]), Number(coords[1]), (item.productOfferingPrice[0].price.taxIncludedAmount/100)]
                    ]);
                  });
                });
              });
          });
        });

        $.getJSON( "http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productOffering?category.id=2307&fields=id,name,description,productOfferingPrice.price,productOfferingPrice.name,productSpecification", function(data) {
          $.each(data, function(i, item){
              $.getJSON("http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productSpecification?id="+item.productSpecification.id+"&fields=id,href,description,relatedParty", function(subData) {
                $.each(subData, function(i, subItem){
                  $.getJSON("http://env-0693795.jelastic.servint.net/DSPartyManagement/api/partyManagement/v2/organization?id="+subItem.relatedParty[0].id+"&fields=id,href,characteristic", function(endData) {
                    var coords = endData[0].characteristic.value.trim().split(',');
                    addMarkers(map, 'restaurant', [
                      [item.name, Number(coords[0]), Number(coords[1]), (item.productOfferingPrice[0].price.taxIncludedAmount/100)]
                    ]);
                  });
                });
              });
          });
        });

        $.getJSON( "http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productOffering?category.id=2309&fields=id,name,description,productOfferingPrice.price,productOfferingPrice.name,productSpecification", function(data) {
          $.each(data, function(i, item){
              $.getJSON("http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productSpecification?id="+item.productSpecification.id+"&fields=id,href,description,relatedParty", function(subData) {
                $.each(subData, function(i, subItem){
                  $.getJSON("http://env-0693795.jelastic.servint.net/DSPartyManagement/api/partyManagement/v2/organization?id="+subItem.relatedParty[0].id+"&fields=id,href,characteristic", function(endData) {
                    var coords = endData[0].characteristic.value.trim().split(',');
                    addMarkers(map, 'monument', [
                      [item.name, Number(coords[0]), Number(coords[1]), (item.productOfferingPrice[0].price.taxIncludedAmount/100)]
                    ]);
                  });
                });
              });
          });
        });

        $.getJSON( "http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productOffering?category.id=2311&fields=id,name,description,productOfferingPrice.price,productOfferingPrice.name,productSpecification", function(data) {
          $.each(data, function(i, item){
              $.getJSON("http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productSpecification?id="+item.productSpecification.id+"&fields=id,href,description,relatedParty", function(subData) {
                $.each(subData, function(i, subItem){
                  $.getJSON("http://env-0693795.jelastic.servint.net/DSPartyManagement/api/partyManagement/v2/organization?id="+subItem.relatedParty[0].id+"&fields=id,href,characteristic", function(endData) {
                    var coords = endData[0].characteristic.value.trim().split(',');
                    addMarkers(map, 'casino', [
                      [item.name, Number(coords[0]), Number(coords[1]), (item.productOfferingPrice[0].price.taxIncludedAmount/100)]
                    ]);
                  });
                });
              });
          });
        });

        $.getJSON( "http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productOffering?category.id=2313&fields=id,name,description,productOfferingPrice.price,productOfferingPrice.name,productSpecification", function(data) {
          $.each(data, function(i, item){
              $.getJSON("http://env-0693795.jelastic.servint.net/DSProductCatalog/api/catalogManagement/v2/productSpecification?id="+item.productSpecification.id+"&fields=id,href,description,relatedParty", function(subData) {
                $.each(subData, function(i, subItem){
                  $.getJSON("http://env-0693795.jelastic.servint.net/DSPartyManagement/api/partyManagement/v2/organization?id="+subItem.relatedParty[0].id+"&fields=id,href,characteristic", function(endData) {
                    var coords = endData[0].characteristic.value.trim().split(',');
                    addMarkers(map, 'fair', [
                      [item.name, Number(coords[0]), Number(coords[1]), (item.productOfferingPrice[0].price.taxIncludedAmount/100)]
                    ]);
                  });
                });
              });
          });
        });



      }


      function setMarkers(map) {

        // Add user and radius around him
        var userCoords = {center: {lat: 38.7223, lng: -9.1393}};
        var image = {
          url: 'images/user.png',
          // This marker is 20 pixels wide by 32 pixels high.
          size: new google.maps.Size(32, 37),
          // The origin for this image is (0, 0).
          origin: new google.maps.Point(0, 0),
          // The anchor for this image is the base of the flagpole at (0, 32).
          anchor: new google.maps.Point(16, 37)
        };
        var marker = new google.maps.Marker({
          position: userCoords.center,
          map: map,
          icon: image,
          zIndex: 15
        });
        // Add the circle for this city to the map.
        var userRadius = new google.maps.Circle({
          strokeColor: '#000000',
          strokeOpacity: 0.6,
          strokeWeight: 2,
          fillColor: '#000000',
          fillOpacity: 0.1,
          map: map,
          center: userCoords.center,
          radius: 1000
        });
      }


      function addMarkers(map, attraction, array) {
        var toogle = false;
        $("body").click(function() {
          if((toogle) && (!$(event.target).is('#markerDescription')) && (!$(event.target).parents("#markerDescription").is("#markerDescription"))) {
              $('#markerDescription').parent().parent().parent().parent().html('');
          }
          toogle = !toogle;
        });

        var image = {
          url: 'images/'+ attraction +'Marker.png',
          // This marker is 20 pixels wide by 32 pixels high.
          size: new google.maps.Size(32, 37),
          // The origin for this image is (0, 0).
          origin: new google.maps.Point(0, 0),
          // The anchor for this image is the base of the flagpole at (0, 32).
          anchor: new google.maps.Point(16, 37)
        };
        // Shapes define the clickable region of the icon. The type defines an HTML
        // <area> element 'poly' which traces out a polygon as a series of X,Y points.
        // The final coordinate closes the poly by connecting to the first coordinate.
        var shape = {
          coords: [1, 1, 1, 32, 37, 32, 37, 1],
          type: 'poly'
        };
        for (var i = 0; i < array.length; i++) {
          var item = array[i];

          var markerInfo = '<div id="markerDescription">'+
                      '<h3 id="firstHeading" class="firstHeading">'+ item[0] +'<span class="text-muted"> - Book</span></h3>'+
                      '<div id="bodyContent">'+
                      '<form id="book">'+
                      '<div class="form-group row">'+
                        '<label for="date" class="col-2 col-form-label">Date</label>'+
                        '<div class="col-9">'+
                          '<input class="form-control" type="date" value="2017-02-07" id="date">'+
                        '</div>'+
                      '</div>'+
                      ((attraction == 'restaurant')?'<div class="form-group row"> \
                        <label for="meal" class="col-5 col-form-label">Meal</label> \
                        <select class="form-control col-6" id="meal"> \
                          <option>Lunch</option> \
                          <option>Dinner</option> \
                        </select> \
                      </div>':'')+
                      '<div class="form-group row">'+
                        '<label for="qtt" class="col-5 col-form-label">Quantity</label>'+
                        '<select class="form-control col-6" id="qtt">'+
                          '<option>1</option>'+
                          '<option>2</option>'+
                          '<option>3</option>'+
                          '<option>4</option>'+
                          '<option>5</option>'+
                        '</select>'+
                      '</div>'+
                      '<p class="'+item[3]+'"><a class="btn btn-success" id="price" href="#">Buy at '+item[3]+'€</a></p></form>'+
                      '</div>'+
                      '</div>';

          var infowindow = new google.maps.InfoWindow({
            content: markerInfo
          });

          var marker = new google.maps.Marker({
            position: {lat: item[2], lng: item[1]},
            map: map,
            icon: image,
            shape: shape,
            title: item[0],
            zIndex: 5
          });
          marker.addListener('click', function() {
            infowindow.open(map, marker);
          });

          $('.container').on('change', '#qtt', function() {
            $('#price').html('Buy at '+ ($('#price').parent().attr("class"))*($('#qtt').val()) +'€');
          });
        }
      }


      function confirmSubmit() {
        if(confirm('Are you sure?')) {
          $('#chargeModal').modal('toggle');
          console.log('success! Add '+ $('#charge-amount').val());
        }
      }
      </script>

    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCGJPmVSc-XxmZmxwZQHYK8qy7cXVNTvOs&callback=initMap">
    </script>


    <ul id="legend"> <strong>Legend:</strong>
      <li class="monument" style="margin-top: 10px">Monuments</li>
      <li class="restaurant">Restaurants</li>
      <li class="bar">Bars</li>
      <li class="cafe">Cafés</li>
      <li class="fair">Fairs</li>
      <li class="casino">Casinos</li>
      <li class="viewpoint">Viewpoint</li>
    </ul>
    </div>

    <div id="accordion" role="tablist" aria-multiselectable="true">
      <div class="card">
        <div class="card-header" role="tab" id="headingOne">
          <h5 class="mb-0">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
              Balance
            </a>
          </h5>
        </div>

        <div id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne">
          <div class="card-block">
            <span id="balance">NA</span>€
            <button class="btn btn-secondary" id="charge" data-toggle="modal" data-target="#chargeModal" href="#">Top Up</button>
          </div>
        </div>
      </div>
    </div>


    <!-- Modal -->
    <div id="chargeModal" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Top Up</h4>
          </div>
          <form id="topUpForm">
          <div class="modal-body">
              <div class="form-group row">
                <label for="example-number-input" class="col-2 col-form-label">Amount</label>
                <div class="col-10">
                  <input class="form-control" type="number" min="0" value="0" id="charge-amount">
                </div>
              </div>
          </div>
          <div class="modal-footer">
            <button type="button" id="confirm" class="btn btn-default" onclick="confirmSubmit()">Confirm</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </form>
        </div>

      </div>
    </div>

    <div style="clear: both"></div>

    <div class="footer">
      <p>Made with ♥ by DaGama team</p>
    </div>

    <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
    <script>
    (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
    function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
    e=o.createElement(i);r=o.getElementsByTagName(i)[0];
    e.src='https://www.google-analytics.com/analytics.js';
    r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
    ga('create','UA-XXXXX-X');ga('send','pageview');
    </script>

    <!-- build:js scripts/vendor.js -->
    <!-- bower:js -->
    <script src="/bower_components/jquery/dist/jquery.js"></script>
    <script src="/bower_components/tether/dist/js/tether.js"></script>
    <script src="/bower_components/modernizr/modernizr.js"></script>
    <!-- endbower -->
    <!-- endbuild -->

    <!-- build:js scripts/plugins.js -->
    <script src="/bower_components/bootstrap/js/dist/util.js"></script>
    <script src="/bower_components/bootstrap/js/dist/alert.js"></script>
    <script src="/bower_components/bootstrap/js/dist/button.js"></script>
    <script src="/bower_components/bootstrap/js/dist/carousel.js"></script>
    <script src="/bower_components/bootstrap/js/dist/collapse.js"></script>
    <script src="/bower_components/bootstrap/js/dist/dropdown.js"></script>
    <script src="/bower_components/bootstrap/js/dist/modal.js"></script>
    <script src="/bower_components/bootstrap/js/dist/scrollspy.js"></script>
    <script src="/bower_components/bootstrap/js/dist/tab.js"></script>
    <script src="/bower_components/bootstrap/js/dist/tooltip.js"></script>
    <script src="/bower_components/bootstrap/js/dist/popover.js"></script>
    <!-- endbuild -->

    <!-- build:js scripts/main.js -->
    <script src="scripts/main.js"></script>
    <!-- endbuild -->
    </body>
    </html>
