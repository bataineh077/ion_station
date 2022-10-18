import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SplashApi extends GetConnect{

  @override
  set timeout(Duration _timeout) {
    // TODO: implement timeout
    super.timeout = _timeout;


    print('Server TimeOut');
  }


  List<String> listVideos = <String>[];

  VideosAPI() {
    // load();
  }

  Future load() async {
    // listVideos = await _getVideoList();
    // print("load $listVideos");
  }

  Future<List<dynamic>> getVideoList() async {
    final response =  await  get('https://public-recycle-server.vercel.app/getResource',

        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin':'*',
        }
        );


    //  timeout = const Duration(seconds: 15);

    if(response.status.hasError){
      //   print( 'in service :' + '${response.body } ${response.statusCode}');

      //  Future.error(response.bodyString.toString());
      print("Error response.body ${response.body} ${response.statusCode}");
      return      response.body;
    } else {
      print("response.body ${response.body}");
      return response.body ;
    }

    // var videoList = <Video>[];
    // var videos;
    //
    // if (data.docs.length == 0) {
    //   await addDemoData();
    //   videos = (await FirebaseFirestore.instance.collection("Videos").get());
    // } else {
    //   videos = data;
    // }
    //
    // videos.docs.forEach((element) {
    //   Video video = Video.fromJson(element.data());
    //   videoList.add(video);
    // });
    //
    // return videoList;
  }

   socketConnection() async {
     IO.Socket socket = IO.io('ws://localhost:8080');
     socket.onConnect((_) async{

       print('connect');

      // socket.emit('connection', 'test');

     });
  }


}