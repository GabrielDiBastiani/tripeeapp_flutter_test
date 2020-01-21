import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_screen_1/model/estimateModel.dart';

class EstimateRequest extends StatefulWidget {
  @override
  _EstimateRequestState createState() => _EstimateRequestState();
}

class _EstimateRequestState extends State<EstimateRequest> {
  Estimate _estimate;
  var loading = false;
  Future<Null> _fetchData() async {
    setState(() {
      loading = true;
    });

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
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjE0MTA1LCJpYXQiOjE1MTI0MDM1NTJ9.cRxqkovPdj3xP7fNh5ddVFTmrAQ77lJClJdNHKnTAtM"
    };

    final response = await http.post(
      'https://estimate.taximanager.com.br/v1/estimates',
      headers: reqHeaders,
      body: json.encode(reqBody),
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        _estimate = Estimate.fromJson(data);
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _estimate.records.length,
                itemBuilder: (context, i) {
                  final records = _estimate.records[i];
                  return Stack(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            records.urlLogo,
                          ),
                        ),
                        title: Text(
                          records.name,
                        ),
                        subtitle: Text(
                          records.modality.name,
                        ),
                        onTap: () {},
                      ),
                      Container(
                        // color: Colors.blue,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Text(records.price),
                            Text('${records.waitingTime} min'),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
