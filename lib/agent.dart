import 'package:flutter/material.dart';
import 'formpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Agent extends StatefulWidget {
  final String auth;
  const Agent({Key? key,required this.auth}) : super(key: key);

  @override
  State<Agent> createState() => _AgentState();
}

class _AgentState extends State<Agent> {
  late List servicesName=[];


  Future getData() async {
    var endpointUrl = 'http://digitalisi.tn:8080/engine-rest/filter/e4f31000-b6f5-11ec-b178-c3179e4f32a6/list';
    Map<String,String> queryParams={
      'firstResult': '0',
      'maxResults': '15',

    };

    Uri uri = Uri.parse(endpointUrl);
    final finalUri = uri.replace(queryParameters: queryParams); //USE THIS
    final response = await http.get(finalUri, headers: <String, String>{'authorization': widget.auth});
    servicesName = json.decode(response.body);
    //print(response.body);
    setState(() {
      servicesName;
    });
    //debugPrint(servicesName.toString());
  }
  @override
  void initState() {
    super.initState();// used for dynamic data
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print ('ServicesName Page');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nos Services"),
        backgroundColor: Colors.indigoAccent[700],
      ),
      body: ListView.builder(
        itemCount: servicesName.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: InkWell( // OnPressed for non buttons
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("${servicesName [index]["name"]} ",
                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,)),

                      )
                    ],
                  ),
                ),)
          );
        },

      ),
    );
  }
}

