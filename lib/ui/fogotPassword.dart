import 'package:flutter/material.dart';
import 'package:qask/api/api.dart';
import 'package:qask/complaintModel.dart';
import 'package:qask/ui/resultScreen.dart';
import 'package:qask/ui/spinner.dart';
import 'package:qask/ui/splashscreen.dart';
import 'package:qask/ui/submitScreen.dart';
import 'package:qask/ui/widgets/custom_shape.dart';
import 'package:qask/ui/widgets/responsive_ui.dart';
import 'package:qask/ui/widgets/textformfield.dart';
import 'package:qask/utils/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key key}) : super(key: key);

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    Widget firstNameTextFormField() {
      return CustomTextField(
        textEditingController: email,
        keyboardType: TextInputType.text,
        icon: Icons.person,
        hint: "Enter your email",
      );
    }

    return Spinner(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(children: [
            Column(
              children: [
                clipShape(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      firstNameTextFormField(),
                      SizedBox(height: 100),
                      button(),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        if (email.text.isNotEmpty) {
          showSpinner();
          var d = await Api().forgotPassword(email: email.text);
          hideSpinner();
          buildToast(d.status == true
              ? 'An email is send to your mail'
              : 'Failed please try again');
          Navigator.pop(context);
          // if (d.status) {
          //   Nav.navigate(context, HomeScreen());
          // }
        } else {
          buildToast('Please fill all values to continue');
        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'SUBMIT',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
