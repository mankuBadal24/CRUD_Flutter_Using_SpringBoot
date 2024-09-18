// // ignore_for_file: unnecessary_string_interpolations

// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;


// class Service{

//   Future<http.Response> saveUser(String name, String email, String address, String mobile) async{

//     var uri = Uri.parse("http://localhost:8080/register");

//     Map<String, String> headers = {"Content-Type": "application/json"};
//     //body
//     Map data = {
//       'name': '$name',
//       'email': '$email',
//       'mobile': '$mobile',
//       'address': '$address',
//     };
//     var body= jsonEncode(data);
//     var response =await http.post(uri,headers:headers ,body:  body);
//     print("${response.body}");
//     return response;
//   }
// }