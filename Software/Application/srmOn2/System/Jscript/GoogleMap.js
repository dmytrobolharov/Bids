
var address = null;
var gblCompanyName = null;
function loadMap(obj) {
    var divMap = document.getElementById('divGoogleMap')
    if (divMap != null) {
        divMap.style.display = 'block';
        var iStyleWidth = divMap.style.width
        var iPosition = iStyleWidth.indexOf("px");
        var iLength = iStyleWidth.substring(0, iPosition)
        if (iLength > 600) {
            var maxZoomOut = 2;
        }
        else{
            var maxZoomOut = 1;
        }
    }
    
    var geocoder;
    var arrLocation = new Array();
    var bounds = new google.maps.LatLngBounds();
    var j = 0;
    var iCount = 0;
    infoWindow = new google.maps.InfoWindow;
    geocoder = new google.maps.Geocoder();

    var map = new google.maps.Map(document.getElementById('divGoogleMap'), {
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    var infoWindow = new google.maps.InfoWindow;

    google.maps.event.addListener(map, 'click', function() {
        infoWindow.close();
    });
    
    for (var i = 0; i < address.length; i++) {
	(function(i){
			geocoder.geocode({ 'address': address[i] }, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					arrLocation[j] = results[0].geometry.location;
					var marker = new google.maps.Marker({ map: map, position: results[0].geometry.location, title: gblCompanyName[i] + '\n' + results[0].formatted_address });

					var attachInfo = function(sCompanyName) {
						var clickMarker = this;
						infoWindow.setContent(attachInfo.CompanyName + '<br />' + attachInfo.VendorAddress);
						infoWindow.open(map, clickMarker);
					};
				   
					attachInfo.CompanyName = gblCompanyName[i];
					attachInfo.VendorAddress = results[0].formatted_address;
					google.maps.event.addListener(marker, 'click', attachInfo);
					google.maps.event.addListener(map, 'zoom_changed', function() {
						var zoomLevel = map.getZoom();
						if (zoomLevel < maxZoomOut) {
							map.setZoom(maxZoomOut);
						}
					});
					j++;
				}
	            iCount++;


				if (iCount == address.length) {

					for (var l = 0; l < arrLocation.length; l++) {
						bounds.extend(arrLocation[l]);
					}
		            if (address.length > 1) {
		                map.fitBounds(bounds)
		            }
		            else if (address.length == 1) {
		                map.setCenter(bounds.getCenter());
		                map.setZoom(16);
		            }
	            

				}
			});
		})(i);
	}
}
function HideMap() {
    document.getElementById('divGoogleMap').style.display = 'none';
}

function MapPosition(obj) {
    Popup.show('divGoogleMap', 'reference', 'center center', { 'constrainToScreen': true, 'offsetTop': -200, 'offsetLeft': 140 });
}