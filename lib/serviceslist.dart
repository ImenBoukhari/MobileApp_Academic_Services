import 'dart:convert';
import 'formpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ServicesList extends StatefulWidget {
  final String auth;
  const ServicesList({Key? key,required this.auth}) : super(key: key);
  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {

  late List servicesName=[];


  Future getData() async {
    var endpointUrl = 'http://digitalisi.tn:8080/engine-rest/process-definition';
    Map<String,String> queryParams={
      'latest': 'true',
      'active': 'true',
      'startableInTasklist':'true',
      'startablePermissionCheck':'true',
      'firstResult' : '0',
      'maxResults' : '15',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage(auth:widget.auth,id:servicesName [index]["id"])),);
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

