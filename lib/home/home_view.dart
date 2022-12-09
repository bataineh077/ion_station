import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'home_controller.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
            init: HomeController(),
            builder: (controller) {
              print("${ controller.numOfElement.value}");
              if (controller.controller.content.isEmpty ) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                  //  controller.qrDialogName();
                    controller. qrDialogWither();
                  },
  //               child: Image.asset("/Users/bilalbataineh/Downloads/IMG_4288-2.jpg"),
                  child: Swiper(
                  //  physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.numOfElement.value,
                    loop: true,
                   autoplay: false,
                    controller: controller.pageController,
                    onIndexChanged: controller.onPageChanged,

                   // axisDirection: Axis.vertical,
                    itemBuilder: (context, itemIndex) {
                      return controller.controller.content[itemIndex];
                    },
                    //itemExtent: Get.size.height,
                  ),
                );
              }
            }),
    bottomSheet: Container(height: 55,color: Colors.green,
    child: Marquee(
      blankSpace: 500.0,
      pauseAfterRound: Duration(seconds: 1),
      startPadding: 10.0,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
      text: 'There once was a boy who told this story about a boy: "',
    ),),);
  }
}
