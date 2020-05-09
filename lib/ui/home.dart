import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  bool hideFab = false;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null)
      setState(() {
        _image = image;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.location_on),
                  Flexible(
                    child: Text(
                      'Vasai, Mumbai, Maharashtra',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black),
                    ),
                  ),
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
            Text('test'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Explore our Insurance Products',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 20,
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
            _BottomAppBarItem(
                assetName: "assets/policy.png", text: 'My Policies'),
            _BottomAppBarItem(
                assetName: "assets/locate.png", text: 'Locate Hospital'),
            _BottomAppBarItem(
                assetName: "assets/claim.png", text: 'Raise Claim'),
            _BottomAppBarItem(
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
            height: 200,
            padding: EdgeInsets.only(top: 10),
            child: Row(children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 10,
                ),
              ),
              Column(
                children: <Widget>[
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

class _BottomAppBarItem {
  final String assetName;
  final String text;
  _BottomAppBarItem({this.assetName, this.text});
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<_BottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    _BottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Icon(item.iconData, color: color, size: widget.iconSize),
                Image.asset(
                  item.assetName,
                  height: 24,
                  color: color,
                ),
                Text(
                  item.text.replaceAll(" ", "\n"),
                  style: TextStyle(color: color),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
