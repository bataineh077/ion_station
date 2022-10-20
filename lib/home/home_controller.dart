import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import '/splash/splash_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';


class HomeController extends GetxController {

  SwiperController pageController = SwiperController();
  SplashController controller = Get.put(SplashController());

  late List<dynamic> videoControllers = [];

  RxInt currentPageIndex = 0.obs;

  RxInt numOfElement = 0.obs;

  int videoControllersIndex = 1;

  late VoidCallback _listener;

  Timer? timer;

  _goNextItem(){

    pageController.next();
        //duration: const Duration(milliseconds: 2000),
        //curve: Curves.fastOutSlowIn);

  }

  void onPageChanged(
    int index,
  ) {
    // TODO: implement onPageChanged

    currentPageIndex.value = index;

    print("currentPageIndex = ${currentPageIndex.value}");

    if (controller.resource[index].contains(".mp4")) {
      if (videoControllersIndex == controller.videoControllers.length) {
        videoControllersIndex = 0;
      }

      var vController = controller.videoControllers[videoControllersIndex];

      _listener = () {
        print(
            "position = ${vController.value.position} ;;; duration = ${vController.value.duration}");



        if (vController.value.isInitialized) {
          print("initialized");
          Duration duration = vController.value.duration;
          Duration position = vController.value.position;

          if (duration.compareTo(position) != 1) {

            _goNextItem();
            vController.removeListener(_listener);

          } else {
          
          }

        }

        if(!vController.value.isPlaying){
        vController.play();
        }
      };

      ++videoControllersIndex;

      vController.play();
      if(!vController.value.isPlaying){

      }

      vController.addListener(_listener);

    } else {
      Future.delayed(Duration(seconds: 6)).then((value) => _goNextItem());
    }
  }

  // calling first time in onReady (after rendering first frame)
  _initFirstElement() async {
    try {
      if (numOfElement > 0) {
        if (controller.resource[currentPageIndex.value].contains(".mp4")) {
          videoControllers[0].setVolume(0.0);
          videoControllers[0].play();

          timer = Timer(videoControllers[0].value.duration, ()=>_goNextItem());

        } else {
          videoControllersIndex = 0;

          Future.delayed(const Duration(seconds: 6)).then((value) => _goNextItem());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        update();
      }
    }
  }



  qrDialog() {
    Phoenix.rebirth(Get.context!);
    Get.reset();
    // Get.
    //  Get.dialog(
    //    Container(
    //      child:
    //      QrImage(data: "ali"),
    //    )
    //  );
  }


  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart {
    numOfElement.value = controller.resource.length;
    return super.onStart;
  }



  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();

    _initFirstElement();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    videoControllers = controller.videoControllers;
  }


  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
    for (var element in controller.videoControllers) {
      element.dispose();
    }
  }
}
