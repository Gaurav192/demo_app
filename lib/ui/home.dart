import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import 'fab.dart';
import 'painter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int index = 0;
  bool hideFab = false;
  File _image;
  Future fetchAddress;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null)
      setState(() {
        _image = image;
      });
  }

  Future<LocationData> fetchLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  Future<String> _getAddress() async {
    try {
      final _location = await fetchLocation().catchError((e) => null);
      if (_location == null) {
        return 'Unable to fetch Location';
      }
      final _coordinates = Coordinates(_location.latitude, _location.longitude);
      final _address =
          await Geocoder.local.findAddressesFromCoordinates(_coordinates);
      final _first = _address.first;
      return "${_first.subLocality ?? ""}, ${_first.subAdminArea ?? ""}, ${_first.adminArea ?? ""}";
    } on Exception catch (e) {
      // print(e);
      return 'Unable to fetch Location';
    }
  }

  ScrollController _controller;
  AnimationController _animationController;
  Animation<double> _tween;
  @override
  void initState() {
    fetchAddress = _getAddress();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _tween = Tween<double>(begin: 0, end: 44).animate(_animationController);
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset <= _controller.position.minScrollExtent &&
            !_controller.position.outOfRange) {
          _animationController.reset();
        } else if (_tween.value == 0) {
          _animationController.forward();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: ListView(
          controller: _controller,
          padding: EdgeInsets.all(16),
          children: <Widget>[
            Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.location_on),
                  FutureBuilder<String>(
                      future: fetchAddress,
                      builder: (context, snapshot) {
                        String _text;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          _text = 'Fetching Address';
                        } else {
                          _text = snapshot.data ?? 'Unable to fetch location';
                        }
                        return Expanded(child: Text(_text));
                      }),
                  IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  IconButton(
                      icon: Image.asset("assets/help.png"), onPressed: () {}),
                  IconButton(icon: Icon(Icons.menu), onPressed: () {})
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.grey[300])),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => getImage(),
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            radius: 60,
                            child: _image == null
                                ? Image.asset('assets/placeholder.png')
                                : Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: FileImage(_image))),
                                  ),
                          ),
                          Positioned(
                            right: 2,
                            bottom: 16,
                            child: Image.asset(
                              "assets/camera.png",
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Jennifer Wilson',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              "assets/location.png",
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 8),
                            Text('Mumbai, India')
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              "assets/calendar.png",
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 8),
                            Text('12-Apr-1994')
                          ],
                        )
                      ],
                    )
                  ],
                )),
            SizedBox(height: 20),
            Text(
              'Health Advisor',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Card(
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    'From treatment guidance to post hospitalization care'),
                                RaisedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Get in touch',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          ),
                          Image.asset("assets/advisor.png")
                        ],
                      ),
                    )),
                itemCount: 4,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Health Rewards',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: AnimatedBuilder(
                animation: _tween,
                builder: (cxt, child) => CustomPaint(
                  painter: ProgressPainter(_tween.value),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Explore our Insurance Products',
              style: Theme.of(context).textTheme.headline6,
            ),
            ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.grey[300])),
                    child: Row(
                      children: <Widget>[
                        Image.asset("assets/insurance.png"),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Health Insurance redefined!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                    'Lorem ipsum dolor sitamet is a placeholder text....'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: 20)
          ],
        ),
        bottomNavigationBar: FABBottomAppBar(
          selectedColor: Colors.black,
          color: Colors.grey,
          onTabSelected: _selectedTab,
          items: [
            BottomAppBarItem(
                assetName: "assets/policy.png", text: 'My Policies'),
            BottomAppBarItem(
                assetName: "assets/locate.png", text: 'Locate Hospital'),
            BottomAppBarItem(
                assetName: "assets/claim.png", text: 'Raise Claim'),
            BottomAppBarItem(
                assetName: "assets/book.png", text: 'Book Services'),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Builder(
          builder: (context) => Visibility(
            visible: !hideFab,
            child: FloatingActionButton(
              onPressed: () {
                _settingModalBottomSheet(context);
                hideFloatingActionButton(true);
              },
              backgroundColor: Colors.white,
              tooltip: 'Home',
              child: Image.asset(
                "assets/home.png",
                height: 36,
              ),
              elevation: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  void _selectedTab(int value) {
    setState(() {
      index = value;
    });
  }

  void hideFloatingActionButton(bool value) {
    setState(() {
      hideFab = value;
    });
  }

  void _settingModalBottomSheet(context) {
    var bottomSheetController = showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.grey[200],
            height: 220,
            child: Row(children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 10,
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                      child: Center(
                          child: Container(
                              width: 50,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              )))),
                  Row(
                    children: <Widget>[
                      Card(
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Option 1'),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                "assets/option.png",
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Card(
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Option 2'),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                "assets/option.png",
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Card(
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Option 3'),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                "assets/option.png",
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Card(
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Option 4'),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                "assets/option.png",
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(flex: 2, child: SizedBox(width: 10))
            ]),
          );
        });
    bottomSheetController.closed.then((value) {
      hideFloatingActionButton(false);
    });
  }
}
