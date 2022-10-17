import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

import 'controller.dart';

class SplashController extends GetxController{

  // List<String> src22 = ["assets/images/Deer - 133888.mp4","assets/images/20220330_115458.jpg" ,
  //   "assets/images/Hiking - 109277.mp4","assets/images/20220330_123558.jpg","assets/images/Jellyfish - 110877.mp4",
  //   "assets/images/car.jpg","assets/images/300161911_1474672539715698_5206436733035932863_n.jpg"];
  //

  List<String> src = [src0,...images,src2,src3, ];


  List<PodPlayerController> vcs = [];

  List<Widget> content = [];

  int j = 0;


  Future initVidController()async{
    //  print(src);

    src.shuffle();

    print(src);

    for (int i = 0; i < src.length; i++) {

      if(src[i].contains(".mp4")){





        vcs.add(
            PodPlayerController(playVideoFrom: PlayVideoFrom.network(
                src[i], ), podPlayerConfig: const PodPlayerConfig( autoPlay: false,
              isLooping: false,))..initialise().catchError((e)=>print(e)));



        content.add(PodVideoPlayer(controller:vcs[j],)..controller.mute());

        // await vcs[j].initialize().then((value) {
        //
        //   print(src[i]);
        // });


        j++;


      }else{

        content.add(Image.network(src[i]));
      }





    }
  //  isInit.value = true;

    print(vcs.length);

  }



  Timer? timer ;

  _startDelay()async{


     await initVidController().then((value) {

        timer = Timer(Duration(seconds: 4) , _goNext);

      });


  }

  _goNext(){

     Get.toNamed("/home");

  }

  @override
  void onInit() {
    // TODO: implement onInit

    _startDelay();
    super.onInit();



  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    timer?.cancel();
  }
  
}