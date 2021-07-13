import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List data;
  var url = Uri.parse("https://swapi.dev/api/people");

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get( Uri.https('swapi.dev', 'api/people'),
      //Encode URL
            headers: {"Accept": "application/json"}
    );

    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);

      data = convertDataToJson['results'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve JSON via HTTP Get"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Container(
                      child: Text(data[index]['name']),
                      padding: EdgeInsets.all(20.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
