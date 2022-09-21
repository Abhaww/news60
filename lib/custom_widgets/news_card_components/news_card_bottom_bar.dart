// import 'dart:ui';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:news60/components/colors.dart';
// import 'package:news60/components/text_styles.dart';
// import 'package:news60/screens/web_view.dart';
// import 'package:news60/utils/utils.dart';
// import 'package:provider/provider.dart';
//
// class BottomBar extends StatelessWidget {
//   final String image;
//   BottomBar({required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => Utils(),
//       child: GestureDetector(
//         onTap: () {
//           /// TODO: i will change this
//           String url = Provider.of<Utils>(context, listen: false).getUrl();
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => WebScreen(url: url),
//             ),
//           );
//         },
//         child: Container(
//           color: Theme.of(context).cardColor,
//           // elevation: 0,
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 width: double.maxFinite,
//                 child: Image(
//                   image: CachedNetworkImageProvider(image),
//                   fit: BoxFit.cover,
//                   alignment: Alignment.center,
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 height: double.maxFinite,
//                 width: double.maxFinite,
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
//                   child: Container(
//                     color: Colors.black.withOpacity(0.4),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: double.maxFinite,
//                 color: AppColor.onBackground.withOpacity(0.6),
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       /// article content is available then retutn it in here
//                       'Dummy News headlines',
//                       maxLines: 1,
//                       style: AppTextStyle.newsBottomTitle,
//                     ),
//                     SizedBox(
//                       height: 4,
//                     ),
//                     Text(
//                       "tap_message",
//                       style: AppTextStyle.newsBottomSubtitle,
//                       overflow: TextOverflow.fade,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
