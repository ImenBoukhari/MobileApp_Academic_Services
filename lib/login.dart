// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'agent.dart';
import 'serviceslist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
// get access to the text fields
  late TextEditingController emailVar;
  late TextEditingController passwordVar;

  @override
  void initState() {
    super.initState();

    // change content
    emailVar = TextEditingController();
    passwordVar = TextEditingController();
  }

// get access to the text fields
  @override
  void dispose() {
    emailVar.dispose();
    passwordVar.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    late List ServicesName;
    print ('login Page');
    // the page content
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column( // V layout in android
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: const NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Institut_Sup%C3%A9rieur_d%27Informatique_%28logo%29.svg/300px-Institut_Sup%C3%A9rieur_d%27Informatique_%28logo%29.svg.png')),
              const Text('ISI vous souhaite les bienvenus', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26,),),
              const SizedBox(height: 10),
              // Email textField
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: TextField(
                      controller: emailVar,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Password textField
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left:20.0),
                    child: TextField(
                      controller:passwordVar,
                      obscureText: true,
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Sign In Button
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: ElevatedButton(
                    child: const Text('Sign In',style: TextStyle(color: Colors.white, fontSize: 20),),
                    onPressed: () async {
                      // search the user login
                      var auth = 'Basic '+base64Encode(utf8.encode(emailVar.text+':'+passwordVar.text));
                      Uri uri = Uri.parse("http://digitalisi.tn:8080/engine-rest/user/");
                      final response = await http.get(uri, headers: <String, String>{'authorization': auth});
                      ServicesName = json.decode(response.body);
                      if(emailVar.text=='agent'){
                        if (response.statusCode == 200) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Agent(auth:auth)));
                        }else {
                          // If that call was not successful, throw an error.
                          throw Exception('Failed to load post');
                        }
                      }
                      else{

                      if (response.statusCode == 200) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServicesList(auth:auth)));
                      }else {
                        // If that call was not successful, throw an error.

                        throw Exception('Failed to load post');
                      }
                    }},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 25.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      primary: Colors.indigoAccent[700],
                    ),
                  ),
                ),),
            ],
          ),
        )
    );
  }
}
