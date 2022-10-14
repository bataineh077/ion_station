import 'dart:async';
import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ion_station/controller.dart';
import 'package:path_provider/path_provider.dart';

class Storage {

  Future<String> get localPath async{
    final dir = await getApplicationDocumentsDirectory();

    return dir.path;
  }

  // Future<File> get localFile async{
  //   final path = await localPath;
  //
  //   return File("$path/vid.mp4" , );
  // }

}




class Home extends GetWidget<HomeController> {

  HomeController _controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {





             return Scaffold(
       // appBar: AppBar(title: Image.network(images[0])),
              body:
                  Obx(
                     () {

                      if(!_controller.isInit.value){
                        return CircularProgressIndicator();
                      }

                      return CarouselSlider(
                        carouselController: _controller.pageController,
                        items: _controller.content,
                          options: CarouselOptions(
                            height: Get.height ,
                            aspectRatio: 16/9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: _controller.duration.value,
                            autoPlayAnimationDuration: const Duration(seconds: 2),
                            autoPlayCurve: Curves.fastOutSlowIn,

                           // enlargeCenterPage: true,
                            onPageChanged: _controller.onPageChanged,
                            scrollDirection: Axis.vertical,

                          )
                      );
                    }
                  )


    );

  }
}
