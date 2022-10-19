import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/splash/splash_api.dart';
import 'package:pod_player/pod_player.dart';


class SplashController extends GetxController {
  List<dynamic> resource = [];

  Timer? timer;

  List<VideoPlayerController> videoControllers = [];

  List<Widget> content = [];

  int j = 0;

  Future initVidController() async {
    await SplashApi().getVideoList().then((List<dynamic> value) {
      resource.clear();
      resource = value;
    //  resource.shuffle();

      resource.forEach((element) {
        if (element.contains(".mp4")) {
          videoControllers.add(VideoPlayerController.network(
            element,
          )..initialize().catchError((e) => print(e)));

          // must be the video is mute for auto play "its browser rules"
          content.add(VideoPlayer(
            videoControllers[j],
          )..controller.setVolume(0.0));

          j++;
        } else {
          content.add(Image.network(
            element,
            height: Get.height,width: Get.width,
            fit: BoxFit.fill,
          ));
        }
      });
    });
  }

  _goNext() {
    Future.delayed(
      Duration(seconds: 3),
    );
    Get.offAndToNamed('/home',);
  }

  _initHome() async {
    await initVidController().then((value) {
      _goNext();
    });
  }



  @override
  void onInit() {

    super.onInit();
    _initHome();
  }

  @override
  void dispose() {

    super.dispose();
    timer?.cancel();
  }
}
