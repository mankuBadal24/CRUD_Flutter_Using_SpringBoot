import 'dart:convert';

import 'package:first_flutter_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:first_flutter_app/view_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class update_dart extends StatefulWidget {
    String id;
    String name;
    String email;
    String address;
    String mobile;
  update_dart(this.id,this.name,this.email,this.address,this.mobile);

  @override
  State<update_dart> createState() => _update_dartState();
}

class _update_dartState extends State<update_dart> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController idController = TextEditingController();

Future<http.Response> updateRecord(String id, String name, String email, String address, String mobile) async {
  var uri = Uri.parse("http://localhost:8080/users/update");

  // Headers
  Map<String, String> headers = {"Content-Type": "application/json"};

  // Body including the id and user fields
  Map<String, dynamic> data = {
    'id': int.parse(id),  // Ensure the ID is passed as an integer
    'user': {
      'name': name,
      'email': email,
      'mobile': mobile,
      'address': address,
    }
  };

  print("$data");
  var body = jsonEncode(data);
  var response = await http.post(uri, headers: headers, body: body);

  print("${response.body}");
  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text("data Updated successfully"),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF0C66CC),
          closeIconColor: Colors.white)
  );
  return response;
}

  @override
  void initState() {
    super.initState();
    idController.text=widget.id;
    nameController.text = widget.name;
    emailController.text=widget.email;
    addressController.text=widget.address;
    mobileController.text=widget.mobile;
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update data"),
        toolbarHeight: 60,
        backgroundColor: Color(0xFF0C66CC),
        titleTextStyle: TextStyle(color: Colors.white , fontSize: 24),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background3rd.jpg"),
                      fit: BoxFit.cover,
                  )
                ),
              ),
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
                                enabled: false,
                                controller: idController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'id',
                                  labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter the Updated Name',
                                  labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter the Updated Email',
                                  labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: addressController,
                              decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter the Updated Address',
                                labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                              ),
                            ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: TextFormField(
                              controller: mobileController,
                              decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your updated Number',
                                labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                              ),
                            ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0C66CC),
                                  padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 38.0)
                                ),
                                onPressed: (){
                                  // update_record();
                                  updateRecord(
                                    idController.text,
                                    nameController.text,
                                    emailController.text,
                                    addressController.text,
                                    mobileController.text);
                                    idController.clear();
                                    nameController.clear();
                                    emailController.clear();
                                    addressController.clear();
                                },
                                child: const Text("Update",
                                style: TextStyle(color: Colors.white),),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Builder(
                                builder: (context){
                                  return ElevatedButton(onPressed: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => view_data()));
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => view_data()),
                                          (Route<dynamic> route) => false,
                                    );
                                  },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF0C66CC),
                                          padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0)
                                      ),
                                      child: const Text("Updated Data",
                                      style: TextStyle(color: Colors.white)));
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(onPressed: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => MyApp()),
                                      (Route<dynamic> route) => false,
                                );
                              },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0C66CC),
                                    padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 14.0)
                                ),
                              child: const Text("Insert New Data",
                              style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                  ),
              )
              )],
      )
    );
  }
}
