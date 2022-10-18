import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import 'home_controller.dart';







class Home extends StatelessWidget {



  @override
  Widget build(BuildContext context) {





             return Scaffold(
       // appBar: AppBar(title: Image.network(images[0])),

              body:


                           GetBuilder(
                             init: HomeController(),
                          builder:   (_controller) {

                              if(_controller.controller.content.isEmpty ){
                                return const Center(child: CircularProgressIndicator(),);
                              }else {
                                return GestureDetector(
                                  onTap: (){_controller.qrDialog();},
                                  child: InfiniteCarousel.builder(
                                   physics:const NeverScrollableScrollPhysics(),
                    itemCount:_controller.numOfElement.value,
                    loop: true,
                                      controller: _controller.pageController,
                                     onIndexChanged: _controller.onPageChanged,
                                    axisDirection: Axis.vertical,
                    itemBuilder: (context, itemIndex, realIndex) {

                          //_controller.controller.vcs[_controller.ii-1].play();


                          return _controller.controller.content[itemIndex];
                    }, itemExtent: Get.size.height,


                                    ),
                                );
                              }
                             }
                           )




    );

  }
}
