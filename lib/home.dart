import 'dart:async';
import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:ion_station/controller.dart';
import 'package:path_provider/path_provider.dart';







class Home extends StatelessWidget {

  final HomeController _controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {





             return Scaffold(
       // appBar: AppBar(title: Image.network(images[0])),
              body:

                           InfiniteCarousel.builder(
                    itemCount:_controller.controller.src.length,
                    loop: true,
                                controller: _controller.pageController,
                               onIndexChanged: _controller.onPageChanged,
                              axisDirection: Axis.vertical,
                    itemBuilder: (context, itemIndex, realIndex) {

                          //_controller.controller.vcs[_controller.ii-1].play();


                          return _controller.controller.content[itemIndex];
                    }, itemExtent: Get.size.height,
                             //   children: _controller.controller.content,

                                  // options: CarouselOptions(
                                  //   height: Get.height ,
                                  //   aspectRatio: 16/9,
                                  //   viewportFraction: 1,
                                  //   initialPage: 0,
                                  //   enableInfiniteScroll: true,
                                  //   reverse: false,
                                  //   autoPlay: false,
                                  //   autoPlayInterval: _controller.duration.value,
                                  //   autoPlayAnimationDuration: const Duration(seconds: 2),
                                  //   autoPlayCurve: Curves.fastOutSlowIn,
                                  //
                                  //  // enlargeCenterPage: true,
                                  //
                                  //
                                  // )
                              )




    );

  }
}
