import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';


String _basicAuth = 'Basic ${base64Encode(utf8.encode(
        'wael:wael12345'))}';
  
    Map<String, String> myheaders = {
          'authorization': _basicAuth
        };



class Curd {
   getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data  ,headers:myheaders );
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.headers.addAll(myheaders) ; 
    request.files.add(multipartFile);
    data.forEach((key, value) {
        request.fields[key] = value ; 
    });
    var myrequest = await request.send();

    var response = await http.Response.fromStream(myrequest) ; 
    if (myrequest.statusCode == 200){
        return jsonDecode(response.body) ; 
    }else {
      print("Error ${myrequest.statusCode}") ; 
    }

  }
}

//!:MultipartRequest => For Uploading Files...
//*:MultipartFile    => For Treating Photos And Has 3 positional arguments(String field,Stream<List<int>> stream,)
//?:BaseName         => Gets the part of [path] after the last separator like => p.basename('kareem/ibrahim/benzema.dart'); -> 'benzema.dart' -> This is photo's path        
//!:Files            => Method Build In Flutter For Uploading Files On Server