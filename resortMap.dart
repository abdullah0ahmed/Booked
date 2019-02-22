import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ResortMap extends StatefulWidget {
  final double lat;
  final double long;
  ResortMap(this.lat, this.long);

  @override
  State<StatefulWidget> createState() {
    return _MyMap(lat, long);
  }
}

class _MyMap extends State<ResortMap> {
  double lat;
  double long;
  _MyMap(this.lat, this.long);
  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    // converting the cordinated into a web-link
    _launchURL() {
      double lat = this.lat;
      double long = this.long;
      var url =
          'http://maps.google.com/?q=' + lat.toString() + "," + long.toString();

      launch(url);
    }

    return SizedBox(
        height: 400.0,
        width: 400.0,
        child: Stack(
          alignment: Alignment(1.0, -1.0),
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                bearing: 270.0,
                target: LatLng(lat, long),
                tilt: 30.0,
                zoom: 17.0,
              ),
              onMapCreated: _onMapCreated,
            ),

            // this sized box is used for the button taking you to the GoogleMaps App
            SizedBox(
              width: 36,
              height: 36,
              child: FloatingActionButton(
                onPressed: _launchURL,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.add_location, size: 25.0),
              ),
            ),
          ],
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
