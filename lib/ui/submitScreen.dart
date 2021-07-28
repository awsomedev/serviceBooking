import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qask/api/api.dart';
import 'package:qask/ui/spinner.dart';
import 'package:qask/utils/navigation.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key key}) : super(key: key);

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  String selectedService;
  TextEditingController query = TextEditingController();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Fluttertoast.showToast(msg: 'Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Write your complaint'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: selectedService,
                        isExpanded: true,
                        hint: Text('Select issue'),
                        onChanged: (s) {
                          setState(() {
                            selectedService = s;
                          });
                        },
                        items: [
                          'Street Light',
                          'Water pipe leakage',
                          'Rain water drainage',
                          'Road',
                          'Computer Sevice',
                        ]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList()),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: TextFormField(
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    controller: query,
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Colors.orange[200],
                    decoration: InputDecoration(
                      hintText: 'Ask you question',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.orange[200])),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.orange[200])),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () async {
                    print('submit working');
                    showSpinner();
                    var location = await _determinePosition();
                    final coordinates =
                        new Coordinates(location.latitude, location.longitude);
                    var addresses = await Geocoder.local
                        .findAddressesFromCoordinates(coordinates);
                    var first = addresses.first;
                    var d = await Api().submitSolutions(
                      service: selectedService,
                      query: query.text,
                      location: '${first.adminArea}, ${first.addressLine}',
                    );
                    hideSpinner();
                    buildToast(d.msg);
                    Navigator.pop(context);
                  },
                  // textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      // gradient: LinearGradient(
                      //   colors: <Color>[Colors.orange[200], Colors.pinkAccent],
                      // ),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Text('SUBMIT', style: TextStyle(fontSize: 14)),
                  ),
                ),
                SizedBox(height: 50),
              ],
            )),
      ),
    );
  }
}
