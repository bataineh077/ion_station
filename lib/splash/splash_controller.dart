import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../mqqt_init.dart';
import '/splash/splash_api.dart';
import 'package:pod_player/pod_player.dart';


class SplashController extends GetxController {
  List<dynamic> resource = [];

  Timer? timer;

  List<VideoPlayerController> videoControllers = [];

  List<Widget> content = [];

  int j = 0;

  Future initVidController() async {
    await getAssets().then((List<dynamic> value) {
      resource.clear();
      resource = value;
    //  resource.shuffle();

      resource.forEach((element) {
        if (element.contains(".mp4")) {
          videoControllers.add(VideoPlayerController.asset(
            element,
          )..initialize().catchError((e) => print(e)));

          // must be the video is mute for auto play "its browser rules"
          content.add(VideoPlayer(
            videoControllers[j],
          )..controller.setVolume(0.0));

          j++;
        } else {
          content.add(Image.asset(
            element,
            height: Get.height,width: Get.width,
            fit: BoxFit.fill,
          ));
        }
      });
    });
  }

  _goNext() {

    Get.offAndToNamed('/home',);
  }


  _initHome() async {

    await initVidController().then((value) {
      _goNext();
    });
  }

Future<List> getAssets()async{

   List resources = [] ;
   var assetsFile = await DefaultAssetBundle.of(Get.context!).loadString('AssetManifest.json');
   final Map<String, dynamic> manifestMap = json.decode(assetsFile);

   manifestMap.forEach((key, value) {
     if(key.toString().contains('resources')){
       print(value[0]);
       resources.add(value[0].toString());
     }
   });




   print(manifestMap);

return resources;

 }

  @override
  void onInit() {

   // getAssets();

    super.onInit();
    _initHome();
  }

  @override
  void dispose() {

    super.dispose();
    timer?.cancel();
  }
}
