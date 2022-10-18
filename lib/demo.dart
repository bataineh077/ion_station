// import 'package:flutter/material.dart';
// import 'package:opscroll_web/opscroll_web.dart';
// import 'package:video_box/video.home_controller.dart';
// import 'package:video_box/video_box.dart';
// import 'package:video_player/video_player.dart';
//
// class ListVideo extends StatefulWidget {
//   @override
//   _ListVideoState createState() => _ListVideoState();
// }
//
// String src1 =
//     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
//
// String src2 =
//     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4';
//
// String src3 =
//     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4';
//
// class _ListVideoState extends State<ListVideo> {
//   List<VideoController> vcs = [];
//   List<String> src = [src1,src2,src3];
//   @override
//
//
//   void initState() {
//     super.initState();
//     for (var i = 0; i < src.length; i++) {
//       vcs.add(VideoController(source: VideoPlayerController.network(src[i],),controllerWidgets:false)
//         ..initialize());
//     }
//
//     vcs[2].autoplay = true;
//     vcs[0].playEndListenner = (VideoController ctrl){
//
//       pageController.animateToPage(goNext(), duration: const Duration(milliseconds: 300),
//           curve: Curves.bounceInOut);
//
//     };
//   }
//
//   @override
//   void dispose() {
//     for (var vc in vcs) {
//       vc.dispose();
//     }
//     super.dispose();
//   }
//   PageController pageController = PageController();
//
//   int _currentPageIndex = 0;
//
//   void onPageChanged(int index) {
//     // TODO: implement onPageChanged
//     _currentPageIndex = index;
//
//   }
//
//
//   int goNext() {
//     // TODO: implement goNext
//     int nextIndex = ++_currentPageIndex  ;
//
//     return nextIndex;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('list video'),
//       ),
//       body: OpscrollWeb(
//         onePageChildren: [
//           for (var vc in vcs)
//             Padding(
//               padding: const EdgeInsets.only(top: 12.0),
//               child: AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: VideoBox(controller: vc),
//               ),
//             ),
//         ], pageController: pageController,
//       ),
//     );
//   }
// }