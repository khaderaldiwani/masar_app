import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masar/model/notifications_model.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';
import 'package:masar/shared/function/expanded_text.dart';

// Widget buildNotificationItem({required NotificationsModel model}) {
//   return Card(
//     color: AppColor.white,
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           alignment: Alignment.center,
//           margin: EdgeInsetsDirectional.symmetric(horizontal: 10 ,vertical: 30),
          
//           height: 60,
//           width: 60,
//           decoration:  BoxDecoration(
//            //   border: Border.symmetric(horizontal: BorderSide(color: AppColor.primaryColor ,width: 5),vertical: BorderSide(color: AppColor.primaryColor)),
//               shape: BoxShape.circle,
//               image: DecorationImage(
                
//                   image: AssetImage(AppImages.notification,), fit: BoxFit.fill)),//invertColors: false,colorFilter: ColorFilter.mode(AppColor.primaryColor,BlendMode.color  )
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20,),
              
//               SizedBox(height: 5,),
//               Text(
//                     "${model.data!.message}",
//                     style: TextStyle(fontSize: 16, color: AppColor.greyapp),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 3,
//                   ),
              
//             SizedBox(height: 10,)
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
Widget buildNotificationItem({required NotificationsModel model}) {
  return Card(
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: AppColor.white,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // أيقونة الإشعار
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primaryColor.withOpacity(0.1),
            ),
            child: Icon(
              Icons.notifications_active,
              color: AppColor.primaryColor,
              size: 26,
            ),
          ),

          const SizedBox(width: 12),

          // نص الإشعار
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عنوان الإشعار
                // Text(
                //   "إشعار جديد",
                //   style: TextStyle(
                //     fontSize: 15,
                //     fontWeight: FontWeight.bold,
                //     color: AppColor.primaryColor,
                //   ),
                // ),
                // const SizedBox(height: 4),

                // محتوى الإشعار
                
                buildExpandableText( 
                  "${model.data!.message}",
                  maxChars: 50,
               style: TextStyle(
                    fontSize: 16,
                    color: AppColor.greyapp,
                    height: 1.4,
                    fontWeight:FontWeight.bold 
                  )
               
               ),
                const SizedBox(height: 6),

                // وقت الإشعار
                Text(
                  model.time ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}







class NotificationModel {
  final String title;
  final DateTime date;

  NotificationModel({required this.title, required this.date});
}

Map<String, List<NotificationsModel>> groupNotificationsByDate(List<NotificationsModel> notifications) {
  final Map<String, List<NotificationsModel>> grouped = {};

  for (var notif in notifications) {
     List<String> parts = notif.date!.split("-");

  int year = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int day = int.parse(parts[2]);
    final dateKey = DateFormat('yyyy-MM-dd').format(DateTime(year,month,day) ); // استخدم intl package

    if (!grouped.containsKey(dateKey)) {
      grouped[dateKey] = [];
    }

    grouped[dateKey]!.add(notif);
  }

  return grouped;
}



String formatDateLabel(String dateString) {
  final date = DateTime.parse(dateString); // مثلاً: "2025-06-17"
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));
  final inputDate = DateTime(date.year, date.month, date.day);

  if (inputDate == today) {
    return "اليوم";
  } else if (inputDate == yesterday) {
    return "أمس";
  } else {
    return DateFormat('yyyy-MM-dd').format(date); // أو أي تنسيق تريده
  }
}
