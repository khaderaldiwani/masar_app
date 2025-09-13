import 'package:flutter/material.dart';
import 'package:masar/model/receipt_Model.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';

// Widget buildReceiptsPaymentItem({required void Function()? onTab,ReceiptModel? model}) {
//   return InkWell(
//     onTap: onTab,
//     child: Card(
//       color: AppColor.white,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 80,
//           //  width: 100,
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadiusDirectional.only(
//                   topStart: Radius.circular(10),
//                   bottomStart: Radius.circular(10),
//                 ),
//                 image: DecorationImage(
//                     image: AssetImage(AppImages.ui), fit: BoxFit.fill)),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 5,),
//                 Text(
//                   "رقم الايصال: ${model!.id}",
//                   style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       color: AppColor.blue),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(height: 5,),
//                 Text(
//                   "اسم الايصال: ${model!.name}",
//                   style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       color: AppColor.greyapp),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(height:2,),
//                 // Row(
//                 //   children: [
//                 //     Text(
//                 //       " Type:",
//                 //       style: TextStyle(fontSize: 17, color: AppColor.black),
//                 //       overflow: TextOverflow.ellipsis,
//                 //       maxLines: 1,
//                 //     ),
//                 //     Expanded(
//                 //       child: Text(
//                 //         " Course",
//                 //         style: TextStyle(fontSize: 17, color: AppColor.black),
//                 //         overflow: TextOverflow.ellipsis,
//                 //         maxLines: 1,
//                 //       ),
//                 //     ),
//                 //     const Spacer(),
                    
//                 //     InkWell(
//                 //       onTap:onTab,
//                 //       child: Container(
//                 //           height: 30,
//                 //           width: 100,
//                 //         alignment: Alignment.center,
//                 //         decoration: BoxDecoration(
//                 //           color: AppColor.secaodColor,
//                 //           borderRadius: BorderRadius.circular(20)
                      
//                 //         ),
//                 //         child: Text(
//                 //           "E-Receipt",
//                 //           style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
//                 //           overflow: TextOverflow.ellipsis,
//                 //           maxLines: 1,
                          
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
               
//                 Row(
//                   children: [
//                     Text(
//                       "الحالة:",
//                       style: TextStyle(fontSize: 17, color: AppColor.greyapp),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
    
//                     Expanded(
//                       child: Text(
//                         " ${model.status}",
//                         style: TextStyle(fontSize: 17, color: AppColor.primaryColor),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                       ),
//                     ),
                    
                    
//                   ],
//                 ),
//               SizedBox(height: 4,)
//               ],
//             ),
//           ),
//           const SizedBox(
//             width: 5,
//           )
//         ],
//       ),
//     ),
//   );
// }
Widget buildReceiptsPaymentItem({
  required void Function()? onTab,
  required ReceiptModel model,
}) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    color: AppColor.white,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_long,
                  color: AppColor.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                
                child:
                defaultHeadTitle(title: "إيصال رقم: ${model.id}",color:AppColor.primaryColor ) 
                // Text(
                //   "إيصال رقم: ${model.id}",
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //     color: AppColor.primaryColor,
                //   ),
                //   overflow: TextOverflow.ellipsis,
                // ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // اسم الايصال
          
          defaultBodyTitle(title: "عنوان الإيصال: ${model.name}",color:AppColor.black,bold: false ), 
      
          const SizedBox(height: 8),

          // الحالة
          Row(
            children: [

              
       defaultSmaleTitle(title: "الحالة: ",color:AppColor.greyapp,bold: false ), 
       defaultBodyTitle(title: model.status ?? "",color:model.status == "مدفوع"
                      ? Colors.green
                      : AppColor.primaryColor,
                      bold: true ), 
            ],
          ),

          const SizedBox(height: 16),

          // زر عرض الإيصال
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: onTab,
              icon: const Icon(Icons.visibility, size: 18, color: Colors.white),
              label:  Text(
                "عرض الإيصال الإلكتروني",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secaodColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget buildReceiptsRefoundItem() {
//   return Card(
//     color: AppColor.white,
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 80,
//           width: 80,
//           decoration: const BoxDecoration(
//               borderRadius: BorderRadiusDirectional.only(
//                 topStart: Radius.circular(10),
//                 bottomStart: Radius.circular(10),
//               ),
//               image: DecorationImage(
//                   image: AssetImage(AppImages.ui), fit: BoxFit.fill)),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "UI UX Design",
//                 style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: AppColor.blue),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//               Row(
//                 children: [
//                   Icon(
//                     Icons.play_lesson_outlined,
//                     color: AppColor.primaryColor,
//                   ),
//                   Text(
//                     " 22 Lessons",
//                     style: TextStyle(fontSize: 14, color: AppColor.grey),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                   const Spacer(),
//                   Icon(
//                     Icons.watch_later_outlined,
//                     color: AppColor.primaryColor,
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Text(
//                       "22 hours 30 mins",
//                       style: TextStyle(fontSize: 14, color: AppColor.grey),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(children: [
//                 Text(
//                 "Done",
//                 style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: AppColor.secaodColor),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//               Spacer(),
//                Text(
//                 "22/22",
//                 style: TextStyle(
//                     fontSize: 15,
//                  //   fontWeight: FontWeight.bold,
//                     color: AppColor.grey
//                     ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               )
//               ],)
              
              
//               //buildProgresBar(completedLessons: 11, totalLessons: 22)
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 5,
//         )
//       ],
//     ),
//   );
// }
