import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EstimateRequest extends StatefulWidget {
  EstimateRequest({Key key}) : super(key: key);

  @override
  _EstimateRequestState createState() => new _EstimateRequestState();
}

class _EstimateRequestState extends State<EstimateRequest> {
  Future<List<Player>> _getPlayers() async {
    Map reqBody = {
      "company_id": 100,
      "user_id": 129,
      "device": {
        "id": "",
        "operation_system": "android",
        "operation_system_version": "6.0",
        "device": "",
        "type_connection": "3g",
        "version_app": "v1.3.0"
      },
      "start": {
        "lat": -23.5644588,
        "lng": -46.6465902,
        "address":
            "Av. Brigadeiro Luís Antônio, 1827 - Bela Vista, São Paulo - SP, Brasil",
        "district": "Bela Vista",
        "city": "São Paulo",
        "state": "SP",
        "zipcode": ""
      },
      "end": {
        "lat": -23.5429399,
        "lng": -46.6686827,
        "address": "Rua Heitor de Morais, 100 - Pacaembu, São Paulo - SP",
        "district": "",
        "city": "São Paulo",
        "state": "SP",
        "zipcode": ""
      },
      "distance": 3200,
      "duration": 11
    };

    Map<String, String> reqHeaders = {
      "Content-type": "application/json",
      "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjE0MTA1LCJpYXQiOjE1MTI0MDM1NTJ9.cRxqkovPdj3xP7fNh5ddVFTmrAQ77lJClJdNHKnTAtM"
    };

    print('inicio response');
    final response = await http.post(
      'https://estimate.taximanager.com.br/v1/estimates',
      headers: reqHeaders,
      body: json.encode(reqBody),
    );

    var jsonData = json.decode(response.body);
    print('jsonData: $jsonData');

    List<Player> players = [];

    for (var jsonPlayer in jsonData['records']) {
      Player player = Player(
        jsonPlayer["id"],
        jsonPlayer["name"],
        jsonPlayer["modality"]["id"],
        jsonPlayer["modality"]["name"],
        jsonPlayer["waiting_time"],
        jsonPlayer["price"],
        jsonPlayer["url_logo"],
      );

      players.add(player);
    }

    print('Player length: ${players.length}');

    return players;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('user'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getPlayers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print('Snapshot data: ${snapshot.data}');
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        snapshot.data[index].logo,
                      ),
                    ),
                    title: Text(
                      snapshot.data[index].name,
                    ),
                    subtitle: Text(
                      snapshot.data[index].modality,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(snapshot.data[index]),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Player player;

  DetailPage(
    this.player,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          player.name,
        ),
      ),
    );
  }
}

class Player {
  final int idName;
  final String name;
  final int idModality;
  final String modality;
  final String time;
  final String price;
  final String logo;

  Player(
    this.idName,
    this.name,
    this.idModality,
    this.modality,
    this.time,
    this.price,
    this.logo,
  );
}
