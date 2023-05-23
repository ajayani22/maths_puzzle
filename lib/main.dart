import 'package:flutter/material.dart';
import 'package:maths_puzzle/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

// class levelpage {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: GridView.builder(
//           itemCount: Model.anslist.length,
//           gridDelegate:
//               SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//           itemBuilder: (context, index) {
//             int cur_lev = Model.prefs?.getInt("cur_lev") ?? 0;
//             String status =
//                 Model.prefs!.getString("status$index") ?? Model.PENDING;
//
//             if (status == Model.CLEAR) {
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) {
//                       return gamepage(index);
//                     },
//                   ));
//                 },
//                 child: Container(
//                   color: Colors.greenAccent,
//                   child: Text("${index + 1}"),
//                 ),
//               );
//             } else if (status == Model.SKIP || index == cur_lev) {
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) {
//                       return gamepage(index);
//                     },
//                   ));
//                 },
//                 child: Container(
//                   color: Colors.yellow,
//                   child: Text("${index + 1}"),
//                 ),
//               );
//             } else {
//               return Container(
//                 color: Colors.red,
//                 child: Text(""),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
