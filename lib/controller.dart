import 'dart:async';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


String src0 = "https://res.cloudinary.com/sosransom/video/upload/v1665714407/Deer_-_133888_qobk2j.mp4";
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


  List<String> src = [src0,src1,...images,src2,src3, ];

  List<CachedVideoPlayerController> vcs = [];


  CarouselController pageController = CarouselController();

  RxInt currentPageIndex = 0.obs;

  Rx<Duration> duration = Duration.zero.obs;


  int j = 0;
 Future initVidController()async{
  //  print(src);
    for (int i = 0; i < src.length; i++) {

      if(src[i].contains(".mp4")){




          vcs.add(
              CachedVideoPlayerController.network(
                  src[i]));



          content.add(CachedVideoPlayer(vcs[j],));

          await vcs[j].initialize().then((value) {
            // isInit.value = true;
            print(src[i]);
          });


          j++;


      }else{

        content.add(Image.network(src[i]));
      }





    }

    // vcs.last.addListener(() {
    //   isInit.value = vcs.last.value.isInitialized;
    // });
    //
    // vcs.last.removeListener(() { });
  print(vcs.length);

  }




  // int goNext() {
  //   // TODO: implement goNext
  //   int nextIndex = ++currentPageIndex.value  ;
  //
  //   if(nextIndex == src.length){
  //     nextIndex = 0;
  //    // currentPageIndex.value = 0;
  //   }
  //
  //   return nextIndex;
  // }

  RxInt ii = 1.obs;

  void onPageChanged(int index,CarouselPageChangedReason c ) {
    // TODO: implement onPageChanged


    //   duration.value = vcs[index].value.duration;
    currentPageIndex.value = index;
    print("currentPageIndex = ${currentPageIndex.value}" );

    if(src[currentPageIndex.value].contains(".mp4")){

      if(ii.value == vcs.length){
        ii.value = 0;

      }

      var vController =vcs[ii.value];




        ii.value++;

        print("ii = "+"${ii.value}");

        vController.play();

        vController.addListener(() {

          if(!vController.value.isPlaying){


            pageController.nextPage( duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn);

          }
        });

  //  vController.removeListener(() { });




     // vController.dispose();


    }else{

      Future.delayed(Duration(seconds: 5)).then((value) =>
      pageController.nextPage( duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn));
    }


  }


  RxBool isInit = false.obs;

@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("ready");


    //
    // pageController.onReady.then((value) => null);
    //

  //  vcs[0].removeListener(() { });

  }

  List<Widget> content = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   print("init");

    initVidController();

    vcs[0].addListener(() {

      print(vcs[0].value.isBuffering);
      if(vcs[0].value.isInitialized ) {

          isInit.value = true;
          vcs[0].play();

      }

      if (!vcs[0].value.isPlaying) {
        pageController.nextPage(duration: const Duration(milliseconds: 300),
            curve: Curves.bounceInOut);
      }
    });


    // src.forEach((element) {
    //   if(element.contains(".mp4")){
    //     content.add(  CachedVideoPlayer(vcs[],),);
    //   }
    // });




  }





}