import 'package:get/get.dart';

class SplashApi extends GetConnect{




  Future<List<dynamic>> getVideoList() async {
    final response =  await  get('https://public-recycle-server.vercel.app/getResource',

        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin':'*',
        }
        );



    if(response.status.hasError){

      return      [response.statusCode];
    } else {
      return response.body ;
    }


  }




}