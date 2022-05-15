import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class FormPage extends StatefulWidget {
  final String auth;
  final String id;

  const FormPage({Key? key,required this.auth, required this.id}) : super(key: key);
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
 late List ServicesName=[];
 late TextEditingController _nameController;
 final _formKey = GlobalKey<FormState>();
  Future getData() async {

    var id=widget.id;
    var endpointUrl = "http://digitalisi.tn:8080/engine-rest/process-definition/$id/form-variables";
    Uri uri = Uri.parse(endpointUrl);
    final response = await http.get(uri, headers: <String, String>{'authorization': widget.auth});
    print(response.body);
    setState(() {
      Map<String, dynamic> ServicesName = new Map<String, dynamic>.from(json.decode(response.body));
      ServicesName ;
      ServicesName.forEach((key, value) {print('${key}');
      this.ServicesName.add(key);
      });

    });

  }
  @override
  void initState() {
    super.initState();// used for dynamic data
    getData();
    //_nameController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Nos Services"),
        backgroundColor: Colors.indigoAccent[700],
      ),
      body: ServicesName.length!=0 ? ListView.builder(

        itemCount: ServicesName .length+1,
        itemBuilder: (BuildContext context, int index) {
          return index<ServicesName.length?Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ServicesName[index], style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,),),
                TextFormField(
                  // The validator receives the text that the user has entered.
                ),

              ],
            ),
          ):Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
              },
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 25.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                primary: Colors.indigoAccent[700],
              ),
            ),
          );







        },
      ): Text("No data"),
    );
  }
}
