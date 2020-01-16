import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  // List<Widget> descriptions = [];
  
  final response =
      // await http.get('https://jsonplaceholder.typicode.com/posts/1');
      await http.get('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=avenida%20univ&key=AIzaSyAJenreCUqFUfAF2ehIT4hLaLhzJW_K0Gw&sessiontoken=1234567890&location=-23.583613,-46.637768&radius=10000&language=pt-BR');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    var parsedJson = json.decode(response.body);
    // print(parsedJson);

    var predictions = parsedJson['predictions'];
    // print('${predictions.runtimeType}: $predictions');

    for (int i = 0; i < predictions.length; i++) {
      print(predictions[i]['description']);
      // descriptions.add(predictions[i]);
    }

    // print(descriptions);




    // return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class Place {
  final String description;

  Place({this.description});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      description: json['predictions']
    );
  }
}



class Request extends StatefulWidget {
  Request({Key key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}