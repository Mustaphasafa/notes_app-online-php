import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;


  String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'mustapha:123456'));
  
    Map<String, String> myheaders = {
          'authorization': _basicAuth
        };

mixin class GetPost {
  getRequest(String request)async{
    try{
var response = await http.get(Uri.parse(request));
    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      return responsebody;
    }else{
      print("error");
    }
    }catch(e){
      print("Error catch $e");
    }
    
  }
  postRequest(String request,Map data)async{
    try{
var response = await http.post(Uri.parse(request),body: data,headers: myheaders);
    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      return responsebody;
    }else{
      print("error");
    }
    }catch(e){
      print("Error catch $e");
    }
    
  }

  postRequestWithFile(String url , Map data , File file)async{
    var request =  http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartfile = http.MultipartFile("file", stream, length ,filename: basename(file.path));
    request.headers.addAll(myheaders);
    request.files.add(multipartfile);
    data.forEach((key,value){
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if(myrequest.statusCode ==200){
      return jsonDecode(response.body);
    }else{
      print("Error ${myrequest.statusCode}");
    }
    }


}