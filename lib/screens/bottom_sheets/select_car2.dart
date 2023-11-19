// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:orbit/components/buttons/submit_btn.dart';
// import 'package:orbit/components/customfont/customFonts.dart';
// import 'package:orbit/constants/app_colors.dart';
// import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:truncate/truncate.dart';

// import '../../models/trip/address.dart';
// import '../../service/providers/trip/route_provider.dart';

// class SelectCarBottomSheet extends StatelessWidget {
//   const SelectCarBottomSheet({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SlidingUpPanel(
//       maxHeight: 300,
//       minHeight: 300,
//       borderRadius: const BorderRadius.only(
//         topRight: Radius.circular(18.0),
//         topLeft: Radius.circular(18.0),
//       ),
//       parallaxEnabled: true,
//       parallaxOffset: .5,
//       panelSnapping: true,
//       backdropEnabled: true,
//       boxShadow: const [
//         BoxShadow(
//           spreadRadius: 6,
//           blurRadius: 4.0,
//           color: Color.fromRGBO(0, 0, 0, 0.05),
//         )
//       ],
//       body: Container(),
//       panelBuilder: (controller) => ConfirmPanelWidget(),
//     );
//   }
// }

// class ConfirmPanelWidget extends StatelessWidget {
//   const ConfirmPanelWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Padding(padding: EdgeInsets.zero);
//     return Container(
//       padding: EdgeInsets.only(
//         left: 20,
//         right: 20,
//       ),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 5,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 20),
//                   CarCategoryCard(isSelected: true, tripFare: 32),
//                   CarCategoryCard(isSelected: false, tripFare: 32),
//                   CarCategoryCard(isSelected: false, tripFare: 32),
//                   CarCategoryCard(isSelected: false, tripFare: 32),
//                   CarCategoryCard(isSelected: false, tripFare: 32),
//                   CarCategoryCard(isSelected: false, tripFare: 32),
//                   CarCategoryCard(isSelected: false, tripFare: 32),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CarCategoryCard extends StatelessWidget {
//   const CarCategoryCard({
//     super.key,
//     required this.tripFare,
//     required this.isSelected,
//   });

//   final double tripFare;
//   final bool isSelected;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Column(
//         children: [
//           Container(
//             padding: isSelected
//                 ? EdgeInsets.only(left: 10, right: 10, top: 9, bottom: 9)
//                 : EdgeInsets.only(top: 9, bottom: 9),
//             margin: isSelected ? null : EdgeInsets.only(left: 10, right: 10),
//             decoration: isSelected
//                 ? BoxDecoration(
//                     color: Color(0xFFFFFCF2),
//                     border: Border.all(
//                       color: AppColors.mainYellow, // Border color
//                       width: 1.0, // Border width
//                     ),
//                     borderRadius: BorderRadius.circular(10.0), // Border radius
//                   )
//                 : BoxDecoration(
//                     color: Color(0xFFFFFFFF),
//                     border: Border(
//                       bottom: BorderSide(
//                         color: Color(0xFFEEEEEE), // Color of the border
//                         width: 1.0, // Thickness of the border
//                       ),
//                     ),
//                     // border: Border.all(
//                     //   color: AppColors.mainYellow, // Border color
//                     //   width: 1.0, // Border width
//                     // ),
//                     // borderRadius: BorderRadius.circular(10.0), // Border radius
//                   ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Image.asset(
//                       // "assets/icons/yellow_car_export.png",
//                       "assets/icons/black_car_icon.png",
//                       width: 72,
//                     ),
//                     SizedBox(
//                       width: 12,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Elite",
//                           style: CustomFonts.poppins(
//                             color: AppColors.mainBlack,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Text("5 min",
//                                 style: CustomFonts.poppins(
//                                   fontSize: 14,
//                                   color: Color(0xFF747682),
//                                   //fontWeight: FontWeight.w600,
//                                 )),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   "assets/svgIcons/profile_icon.svg",
//                                   width: 10,
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text("4",
//                                     style: CustomFonts.poppins(
//                                       fontSize: 14,
//                                       color: Color(0xFF747682),
//                                     )),
//                               ],
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             //if (carCategoryEntity.best_save == true)
//                             // Text(
//                             //   "Best save",
//                             //   style: CustomFonts.poppins(
//                             //     fontSize: 14,
//                             //     fontWeight: FontWeight.w600,
//                             //     color: AppColors.mainYellow,
//                             //   ),
//                             // ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 Text(
//                   "GH ${tripFare.round()}",
//                   style: CustomFonts.poppins(
//                     color: AppColors.mainBlack,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
