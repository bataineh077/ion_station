import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

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
                    controller.qrDialog();
                  },
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
            }));
  }
}
