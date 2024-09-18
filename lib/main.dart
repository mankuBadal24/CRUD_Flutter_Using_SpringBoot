import 'dart:convert';
import 'dart:developer';

import 'package:first_flutter_app/view_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Operation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Service service = Service();


Future<http.Response> saveUser(String name, String email, String address, String mobile) async{

    var uri = Uri.parse("http://localhost:8080/register");

    Map<String, String> headers = {"Content-Type": "application/json"};
    //body
    Map data = {
      'name': '$name',
      'email': '$email',
      'mobile': '$mobile',
      'address': '$address',
    };
    var body= jsonEncode(data);
    var response =await http.post(uri,headers:headers ,body:  body);
    print("${response.body}");
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text("Record Inserted Successfully"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.redAccent,
          closeIconColor: Colors.white,)
        );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('CRUD Operation')),
        backgroundColor: Colors.redAccent,
        toolbarHeight: 60,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Back.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered form
          Center(
            child: SingleChildScrollView(
              child: Card(
                color: Colors.white.withOpacity(0.8), // Optional: to make form stand out from the background
                margin: const EdgeInsets.all(20),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            hintText: 'Enter Your Name'
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter Your Email'
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                            hintText: 'Enter Your Address'
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mobile',
                            hintText: 'Enter Your Mobile'
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 25.0),
                          ),
                          onPressed: () {
                            // Your onPressed function here
                            saveUser(
                              nameController.text,
                              emailController.text,
                              addressController.text,
                              phoneController.text,
                            );
                            nameController.clear();
                            emailController.clear();
                            addressController.clear();
                            phoneController.clear();
                          },
                          child: const Text(
                            'Insert',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(10),
                          child: Builder(
                            builder: (context){
                              return ElevatedButton(onPressed: (){
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => view_data()),
                                      (Route<dynamic> route) => false,
                                );
                              },
                                  style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                    padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 15.0),
                                  ), child: const Text("View Data",
                              style: TextStyle(color: Colors.white),));
                            },
                          )
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
