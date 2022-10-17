import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:ion_station/splash_controller.dart';


String src0 = "https://static.videezy.com/system/resources/previews/000/037/795/original/DH064.mp4";
String src1 =
    'https://res.cloudinary.com/sosransom/video/upload/v1665714407/Hiking_-_109277_pcumou.mp4';

String src2 =
    'https://res.cloudinary.com/sosransom/video/upload/v1665714406/Jellyfish_-_110877_hmp2nq.mp4';

String src3 =
    'https://res.cloudinary.com/sosransom/video/upload/v1665714405/Boat_-_130918_kogx3p.mp4';


List<String> images = ['https://images.unsplash.com/photo-1665586072574-56b4dd11b941?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
'https://images.unsplash.com/photo-1665659611374-8e69a757ebf8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
'https://images.unsplash.com/photo-1665519195240-c597796156ea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80'];

class HomeController extends GetxController{







  InfiniteScrollController pageController = InfiniteScrollController();

  RxInt currentPageIndex = 0.obs;

  RxBool duration = false.obs;



   SplashController controller = Get.put(SplashController());



  int ii = 1;

late  VoidCallback _listener;



  void onPageChanged(int index, ) {
    // TODO: implement onPageChanged


    //   duration.value = vcs[index].value.duration;
    currentPageIndex.value = index;


    print("currentPageIndex = ${currentPageIndex.value}" );

    if(controller.src[currentPageIndex.value].contains(".mp4")){

      if(ii == controller.vcs.length){
        ii = 0;

      }

      var vController =controller.vcs[ii];




      _listener = () {
        print("position = ${ vController.videoPlayerValue!.position} ;;; duration = ${vController.videoPlayerValue!.duration}");

        if (vController.isInitialised) {


            Duration duration = vController.videoPlayerValue!.duration;
            Duration position = vController.videoPlayerValue!.position;


            if (duration.compareTo(position) != 1 ) {
              pageController.nextItem( duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastOutSlowIn);
              vController.removeListener(_listener);
            }else{

              print("ali");
            }



        }
      };


      ii++;

    //  print();
      if(vController.videoState.name == "paused"){
        vController.mute();
        vController.play();
      }

      vController.addListener(_listener);




      print("ii = "+"${ii}");








     // vController.dispose();


    }else{

      Future.delayed(Duration(seconds: 6)).then((value) =>
      pageController.nextItem( duration: const Duration(milliseconds: 2000),
          curve: Curves.fastOutSlowIn));
    }


  }


  RxBool isInit = false.obs;

  Timer? timer ;

  _startDelay()async{

    try{

      if(controller.src[currentPageIndex.value].contains(".mp4")) {


        controller.vcs[0].mute();
        controller.vcs[0].play();


        timer = Timer(controller.vcs[0].totalVideoLength ,(){  pageController.nextItem( duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn);} );

      }else{

        ii= 0;

        Future.delayed(Duration(seconds: 6)).then((value) =>
            pageController.nextItem( duration: const Duration(milliseconds: 2000),
                curve: Curves.fastOutSlowIn));


      }


    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }


  }


@override
  void onReady() {
    // TODO: implement onReady
    print("ready");

    super.onReady();

    _startDelay();

  }









}