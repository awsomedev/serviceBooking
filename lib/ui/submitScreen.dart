import 'package:flutter/material.dart';
import 'package:qask/api/api.dart';
import 'package:qask/ui/spinner.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key key}) : super(key: key);

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  String selectedService;
  TextEditingController quesry = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask you Question'),
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
                      hint: Text('Select service'),
                      onChanged: (s) {
                        setState(() {
                          selectedService = s;
                        });
                      },
                      items: ['Repair', 'Plumbing', 'Computer Sevice']
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
                onPressed: () {
                  showSpinner();
                  var d = Api().submitSolutions(
                    service: selectedService,
                    query: quesry.text,
                    location: 'locatiomn'
                  );
                  hideSpinner();
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
    );
  }
}
