import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: Colors.grey[300])),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: MediaQuery.of(context).size.width * 0.15,
                        child: Image.asset('assets/placeholder.png'),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Image.asset(
                          "assets/camera.png",
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
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
    );
  }
}
