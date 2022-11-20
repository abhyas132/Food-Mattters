import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  var name = "Bhagya";
  var connections = 3;
  var listOfConnections = [
    "Spandan NGO",
    "Meera NGO",
    "Upchild foundation",
    "Shubh foundation",
    "KarBhalaHoBhala NGO",
    "KuchBhi NGO"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_literals_to_create_immutables
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(50),
        child: Column(children: <Widget>[
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('images/splash.png'),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Text(
            "Hello ${name}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue[300],
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Container(
            height: 30,
            child: GestureDetector(
                onTap: () => {},
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromARGB(239, 33, 149, 243),
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 2.0,
                        spreadRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.blue[300],
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(
                  "History",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "You have made ${connections} connections in total",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                ),
                Container(
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.all(1),
                    height: 100,
                    width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (context, index) => Card(
                        color: Colors.lightBlue.shade600,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: Text(listOfConnections[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                        ),
                      ),
                      itemCount:
                          4, //we will only show first 3-4 connections here , on click of the "Show history" we can show more on next screen
                    )),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Row(children: <Widget>[
                Icon(Icons.help_outline_rounded),
                SizedBox(width: 6),
                Text('Help and FAQs')
              ]),
              Row(children: <Widget>[
                Icon(Icons.settings),
                SizedBox(width: 6),
                Text('Settings')
              ]),
              Row(children: <Widget>[
                Icon(Icons.bar_chart),
                SizedBox(width: 6),
                Text('Show donnation graph')
              ])
            ],
          )
        ]),
      ),
    );
  }
}
