import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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

   socketConnection() async {
     IO.Socket socket = IO.io('ws://localhost:8080');
     socket.onConnect((_) async{

       print('connect');

      // socket.emit('connection', 'test');

     });
  }


}