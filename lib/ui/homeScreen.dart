import 'package:flutter/material.dart';
import 'package:qask/api/api.dart';
import 'package:qask/complaintModel.dart';
import 'package:qask/ui/resultScreen.dart';
import 'package:qask/ui/spinner.dart';
import 'package:qask/ui/splashscreen.dart';
import 'package:qask/ui/submitScreen.dart';
import 'package:qask/ui/widgets/custom_shape.dart';
import 'package:qask/ui/widgets/responsive_ui.dart';
import 'package:qask/utils/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[200],
        onPressed: () {
          Nav.navigate(context, SubmitScreen()).then((value) {
            setState(() {});
          });
        },
      ),
      body: FutureBuilder<ComplaintModel>(
          future: Api().getSolutions(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.blueGrey[900]),
                ),
              );
            }
            var complaints = snapshot.data.complaints;
            return Container(
              child: Stack(children: [
                Column(
                  children: [
                    clipShape(),
                  ],
                ),
                complaints.length == 0
                    ? Center(
                        child: Text(
                          'No records',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: _large
                                ? _height / 4 - 10
                                : (_medium ? _height / 3.75 : _height / 3.5) -
                                    10,
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await Api().getSolutions();
                                setState(() {});
                                return true;
                              },
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    print('tapping');
                                    Nav.navigate(
                                        context,
                                        ResultScreen(
                                          data: complaints[index],
                                        ));
                                  },
                                  child: PhysicalModel(
                                    color: Colors.white,
                                    shadowColor: Colors.orange[200],
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(complaints[index].service,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    Colors.orange[200],
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: Colors.black,
                                                ),
                                              )
                                              // Text('Date',
                                              //     style: TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                complaints[index].query,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              Container(
                                                child: Text(
                                                  complaints[index]
                                                      .complaintStatus
                                                      .toUpperCase(),
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.orange[200]),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 20),
                                itemCount: complaints.length,
                              ),
                            ),
                          )
                        ],
                      ),
              ]),
            );
          }),
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
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 30
                  : (_medium ? _height / 25 : _height / 20)),
          child: SafeArea(
              child: Stack(
            children: [
              Center(
                child: Text(
                  'Online complaint\nmanagement system',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton(
                      onSelected: (v) async {
                        var pref = await SharedPreferences.getInstance();
                        await pref.clear();
                        Nav.navigateAll(context, SplashScreen());
                      },
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Log out'),
                              value: 1,
                            )
                          ]),
                ],
              )
            ],
          )),
        ),
      ],
    );
  }
}
