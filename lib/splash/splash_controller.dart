import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/splash/splash_api.dart';
import 'package:pod_player/pod_player.dart';

import '../home/home_controller.dart';

class SplashController extends GetxController{

  // List<String> src22 = ["assets/images/Deer - 133888.mp4","assets/images/20220330_115458.jpg" ,
  //   "assets/images/Hiking - 109277.mp4","assets/images/20220330_123558.jpg","assets/images/Jellyfish - 110877.mp4",
  //   "assets/images/car.jpg","assets/images/300161911_1474672539715698_5206436733035932863_n.jpg"];
  //



  List<dynamic> src = [src3,src1,...images,src0];


  List<VideoPlayerController> vcs = [];

  List<Widget> content = [];

  int j = 0;


  Future initVidController()async{
    //  print(src);

   await SplashApi().getVideoList().then((List<dynamic> value) {


      src.clear();
      src  = value;
      src.shuffle();

      print(src);

      src.forEach((element) {

        if(element.contains(".mp4")){





          vcs.add(
              VideoPlayerController.network(
                element, )..initialize().catchError((e)=>print(e)));



          content.add(VideoPlayer(vcs[j],)..controller.setVolume(0.0));

          // await vcs[j].initialize().then((value) {
          //
          //   print(src[i]);
          // });


          j++;


        }else{

          content.add(Image.network( element,fit: BoxFit.fill,));
        }

      });

      //  isInit.value = true;

      print(vcs.length);

    });



  }



  Timer? timer ;

  _startDelay()async{


    await initVidController().then((value) {

      _goNext();

    });


  }

  _goNext(){

    Future.delayed(Duration(seconds: 3), );
    Get.offAndToNamed("/home");

  }

  @override
  void onInit() {
    // TODO: implement onInit


    super.onInit();
    _startDelay();


  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    timer?.cancel();
  }

}