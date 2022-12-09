import 'dart:async';
import 'dart:convert';

import 'package:blur/blur.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import '../mqqt_init.dart';
import '/splash/splash_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';


class HomeController extends GetxController {

  SwiperController pageController = SwiperController();
  SplashController controller = Get.put(SplashController());

  late List<dynamic> videoControllers = [];

//  RxInt currentPageIndex = 0.obs;

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

   // currentPageIndex.value = index;

    print("currentPageIndex = ${index}");

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


      if(!vController.value.isPlaying){
        vController.play();
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
        if (controller.resource[0].contains(".mp4")) {
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


  qrDialogWither() {



    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.0),
      transitionDuration: Duration(milliseconds: 1000),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment(-1.0,-0.9),
          child: Material(
            color:  Colors.amber.withOpacity(0.1),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("25°C" , style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold ),
                      textAlign:TextAlign.center),
                  Text("مشمس غالبا", style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold ),
                      textAlign:TextAlign.center ),
                  Text("Mostly Sunny", style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold ),
                      textAlign:TextAlign.center ),
                ],
              ),
            ),
          ).frosted(
            blur: 5,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),

            //  padding: EdgeInsets.all(8),
          ),

        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(-0.22, 0), end: Offset(0, 0.0)).animate(anim1),
          child: child,
        );
      },
    );

    // Get.dialog(
    //   AnimatedAlign(
    //     curve : Curves.easeIn,
    //     alignment: Alignment.centerLeft,
    //     duration: Duration(seconds: 2),
    //     child: Material(
    //       color:  Colors.transparent,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //
    //       child: Padding(
    //         padding: const EdgeInsets.all(15.0),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             SizedBox(
    //               width: 300,
    //               height: 300,
    //               child: Container(
    //                   padding: const EdgeInsets.all(8.0),
    //                   decoration: BoxDecoration(
    //                       color:  Colors.transparent,
    //                       border: Border.all(color: Colors.black, width: 5),
    //                       borderRadius: BorderRadius.circular(10)
    //                   ),
    //
    //                   child: QrImage(data: "ali",gapless:false,
    //                   )),
    //             ),
    //             SizedBox(height: 20,),
    //             const Text('Scan The QR code to Start Charging',style: TextStyle(
    //                 fontWeight: FontWeight.w600 , fontSize: 16
    //             ),),
    //
    //             SizedBox(height: 50,),
    //             Row(
    //               mainAxisSize: MainAxisSize.min,
    //               children: const [
    //                 Image(image: AssetImage("assets/images/google-play.png"),width: 25,),
    //                 Text("ION" , style: TextStyle(
    //                     fontWeight: FontWeight.w800 , fontSize: 18
    //                 ))
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ).frosted(
    //       blur: 5,
    //       borderRadius: BorderRadius.circular(20),
    //       padding: EdgeInsets.all(8),
    //     ),
    //   ),
    //    //  transitionCurve:Curves.linear,
    //   // transitionDuration: Duration(seconds: 2)
    // );
  }

  qrDialogName() {



    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.0),
      transitionDuration: Duration(milliseconds: 1000),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color:  Colors.amber.withOpacity(0.1),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Welcome" , style: TextStyle(fontSize: 9),
                      textAlign:TextAlign.center),
                  Text("Mohammed Tawalbeh", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),
                      textAlign:TextAlign.center ),

                ],
              ),
            ),
          ).frosted(
            blur: 5,
            borderRadius: BorderRadius.circular(10),
            //  padding: EdgeInsets.all(8),
          ),

        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 0), end: Offset(0, 0.02)).animate(anim1),
          child: child,
        );
      },
    );

    // Get.dialog(
    //   AnimatedAlign(
    //     curve : Curves.easeIn,
    //     alignment: Alignment.centerLeft,
    //     duration: Duration(seconds: 2),
    //     child: Material(
    //       color:  Colors.transparent,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //
    //       child: Padding(
    //         padding: const EdgeInsets.all(15.0),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             SizedBox(
    //               width: 300,
    //               height: 300,
    //               child: Container(
    //                   padding: const EdgeInsets.all(8.0),
    //                   decoration: BoxDecoration(
    //                       color:  Colors.transparent,
    //                       border: Border.all(color: Colors.black, width: 5),
    //                       borderRadius: BorderRadius.circular(10)
    //                   ),
    //
    //                   child: QrImage(data: "ali",gapless:false,
    //                   )),
    //             ),
    //             SizedBox(height: 20,),
    //             const Text('Scan The QR code to Start Charging',style: TextStyle(
    //                 fontWeight: FontWeight.w600 , fontSize: 16
    //             ),),
    //
    //             SizedBox(height: 50,),
    //             Row(
    //               mainAxisSize: MainAxisSize.min,
    //               children: const [
    //                 Image(image: AssetImage("assets/images/google-play.png"),width: 25,),
    //                 Text("ION" , style: TextStyle(
    //                     fontWeight: FontWeight.w800 , fontSize: 18
    //                 ))
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ).frosted(
    //       blur: 5,
    //       borderRadius: BorderRadius.circular(20),
    //       padding: EdgeInsets.all(8),
    //     ),
    //   ),
    //    //  transitionCurve:Curves.linear,
    //   // transitionDuration: Duration(seconds: 2)
    // );
  }

  qrDialogCharging() {



    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.0),
      transitionDuration: Duration(milliseconds: 1000),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color:  Colors.amber.withOpacity(0.1),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text("your charging session started", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),
                      textAlign:TextAlign.center ),

                ],
              ),
            ),
          ).frosted(
            blur: 5,
            borderRadius: BorderRadius.circular(10),
            //  padding: EdgeInsets.all(8),
          ),

        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 0), end: Offset(0, 0.02)).animate(anim1),
          child: child,
        );
      },
    );

    // Get.dialog(
    //   AnimatedAlign(
    //     curve : Curves.easeIn,
    //     alignment: Alignment.centerLeft,
    //     duration: Duration(seconds: 2),
    //     child: Material(
    //       color:  Colors.transparent,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //
    //       child: Padding(
    //         padding: const EdgeInsets.all(15.0),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             SizedBox(
    //               width: 300,
    //               height: 300,
    //               child: Container(
    //                   padding: const EdgeInsets.all(8.0),
    //                   decoration: BoxDecoration(
    //                       color:  Colors.transparent,
    //                       border: Border.all(color: Colors.black, width: 5),
    //                       borderRadius: BorderRadius.circular(10)
    //                   ),
    //
    //                   child: QrImage(data: "ali",gapless:false,
    //                   )),
    //             ),
    //             SizedBox(height: 20,),
    //             const Text('Scan The QR code to Start Charging',style: TextStyle(
    //                 fontWeight: FontWeight.w600 , fontSize: 16
    //             ),),
    //
    //             SizedBox(height: 50,),
    //             Row(
    //               mainAxisSize: MainAxisSize.min,
    //               children: const [
    //                 Image(image: AssetImage("assets/images/google-play.png"),width: 25,),
    //                 Text("ION" , style: TextStyle(
    //                     fontWeight: FontWeight.w800 , fontSize: 18
    //                 ))
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ).frosted(
    //       blur: 5,
    //       borderRadius: BorderRadius.circular(20),
    //       padding: EdgeInsets.all(8),
    //     ),
    //   ),
    //    //  transitionCurve:Curves.linear,
    //   // transitionDuration: Duration(seconds: 2)
    // );
  }
  qrDialog() {

    // Phoenix.rebirth(Get.context!);
    // Get.reset();
    //
    // showAnimatedDialog(
    //   alignment:Alignment.topLeft,
    // context: Get.context!,
    // barrierDismissible: true,
    // builder: (BuildContext context) {
    // return ClassicGeneralDialogWidget(
    // titleText: 'Title',
    // contentText: 'content',
    // onPositiveClick: () {
    // Navigator.of(context).pop();
    // },
    // onNegativeClick: () {
    // Navigator.of(context).pop();
    // },
    // );
    // },
    // animationType: DialogTransitionType.slideFromLeft,
    // );

    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.0),
      transitionDuration: Duration(milliseconds: 1500),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment(1.0,-0.5),
          child: Material(
            color:  Colors.amber.withOpacity(0.1),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10),
              // ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("TO START CHARGING \n ENTER" , style: TextStyle(fontSize: 8),
                      textAlign:TextAlign.center),
                  Text(" 0000", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,letterSpacing: 12,),
                      textAlign:TextAlign.center ),

                  Text('IN ION APP', style: TextStyle(fontSize: 8),
                      textAlign:TextAlign.center)
                ],
              ),
            ),
          ).frosted(
          blur: 5,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
        //  padding: EdgeInsets.all(8),
        ),
          // child: Material(
          //   color:  Colors.transparent,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //
          //   child: Padding(
          //     padding: const EdgeInsets.all(15.0),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         SizedBox(
          //           width: 300,
          //           height: 300,
          //           child: Container(
          //               padding: const EdgeInsets.all(8.0),
          //               decoration: BoxDecoration(
          //                   color:  Colors.transparent,
          //                   border: Border.all(color: Colors.black, width: 5),
          //                   borderRadius: BorderRadius.circular(10)
          //               ),
          //
          //               child: QrImage(data: "ali",gapless:false,
          //               )),
          //         ),
          //         SizedBox(height: 20,),
          //         const Text('Scan The QR code to Start Charging',style: TextStyle(
          //             fontWeight: FontWeight.w600 , fontSize: 16
          //         ),),
          //
          //         SizedBox(height: 50,),
          //         Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: const [
          //             Image(image: AssetImage("assets/images/google-play.png"),width: 25,),
          //             Text("ION" , style: TextStyle(
          //                 fontWeight: FontWeight.w800 , fontSize: 18
          //             ))
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ).frosted(
          //   blur: 5,
          //   borderRadius: BorderRadius.circular(20),
          //   padding: EdgeInsets.all(8),
          // ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0.22, 0), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );

     // Get.dialog(
     //   AnimatedAlign(
     //     curve : Curves.easeIn,
     //     alignment: Alignment.centerLeft,
     //     duration: Duration(seconds: 2),
     //     child: Material(
     //       color:  Colors.transparent,
     //       shape: RoundedRectangleBorder(
     //         borderRadius: BorderRadius.circular(10),
     //       ),
     //
     //       child: Padding(
     //         padding: const EdgeInsets.all(15.0),
     //         child: Column(
     //           mainAxisSize: MainAxisSize.min,
     //           children: [
     //             SizedBox(
     //               width: 300,
     //               height: 300,
     //               child: Container(
     //                   padding: const EdgeInsets.all(8.0),
     //                   decoration: BoxDecoration(
     //                       color:  Colors.transparent,
     //                       border: Border.all(color: Colors.black, width: 5),
     //                       borderRadius: BorderRadius.circular(10)
     //                   ),
     //
     //                   child: QrImage(data: "ali",gapless:false,
     //                   )),
     //             ),
     //             SizedBox(height: 20,),
     //             const Text('Scan The QR code to Start Charging',style: TextStyle(
     //                 fontWeight: FontWeight.w600 , fontSize: 16
     //             ),),
     //
     //             SizedBox(height: 50,),
     //             Row(
     //               mainAxisSize: MainAxisSize.min,
     //               children: const [
     //                 Image(image: AssetImage("assets/images/google-play.png"),width: 25,),
     //                 Text("ION" , style: TextStyle(
     //                     fontWeight: FontWeight.w800 , fontSize: 18
     //                 ))
     //               ],
     //             )
     //           ],
     //         ),
     //       ),
     //     ).frosted(
     //       blur: 5,
     //       borderRadius: BorderRadius.circular(20),
     //       padding: EdgeInsets.all(8),
     //     ),
     //   ),
     //    //  transitionCurve:Curves.linear,
     //   // transitionDuration: Duration(seconds: 2)
     // );
  }


  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart {
    numOfElement.value = controller.resource.length;
    return super.onStart;
  }




  MQTTClientWrapper newclient = MQTTClientWrapper();

  RxString state = "disabled".obs;

  initMttq()async{
    await newclient.prepareMqttClient();

    newclient.client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

     // print(c[0].topic[c[0].topic.length-2]);

      state.value = json.decode(pt)['screen'];
     // print('state = ${state.value}');

      switch(state.value){
        case "charging":

       //   Screen = <ChargingScreen  language={this.props.language} endTimestamp={this.props.endTimestamp} amount={this.props.amount} kwh={this.props.kwh}
    //  title={I18n.t("remainingTime",{locale:this.props.language})}/>;
      break;
      case "pin-qr":
     // Screen = <AvailableScreen  qr={this.props.qr} pincode={this.props.pin}/>;
      break;

      case "error":
    //  Screen  = <ErrorScreen title={I18n.t("error",{locale:this.props.language})} text={I18n.t(this.props.textKey||"errorSubtitle",{locale:this.props.language})}/>;
      break;
      case "disabled":
        print("hi");
    //  Screen  = <DisabledScreen title={I18n.t("disabled")} text={I18n.t("disabledSubtitle")} />;
      break;

      case "plug-in-car":
     // Screen  = <PlugCarScreen text={I18n.t("plugCar")}/>;
      break;

      case "penalty":
    //  Screen = <DoneChargingScreen text={I18n.t("penalty",{locale:this.props.language})} endTimestamp={this.props.endTimestamp} />;
      break;

      default:
     // Screen = <LoadingScreen/>;
      break;
    }
    //  print('EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      // print('');
    });
  }


  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();

  //  _initFirstElement();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    videoControllers = controller.videoControllers;
    initMttq();
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
