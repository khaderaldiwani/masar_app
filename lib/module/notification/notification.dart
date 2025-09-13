import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/layout/home_layout/cubit/home_layout_cubit.dart';
import 'package:masar/model/notifications_model.dart';
import 'package:masar/module/notification/cubit/notification_cubit.dart';
import 'package:masar/module/notification/cubit/notification_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/Notification_component.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});
  // final List<NotificationModel> notifications = [
  //   NotificationModel(
  //       title: 'New message from Ahmed', date: DateTime(2025, 6, 19)),
  //   NotificationModel(title: 'System update', date: DateTime(2025, 6, 19)),
  //   NotificationModel(title: 'System update', date: DateTime(2025, 6, 18)),
    
  //   NotificationModel(title: 'Reminder: Meeting', date: DateTime(2025, 6, 16)),
  //   NotificationModel(
  //       title: 'New comment on your post', date: DateTime(2025, 6, 16)),
  // ];
  @override
  Widget build(BuildContext context) {
  //  final grouped = groupNotificationsByDate(notifications);
    return BlocProvider(
      create: (context) => NotificationCubit()..init(),
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {},
        builder: (context, state) {
             HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
             

   
         Map<String, List<NotificationsModel>> groupedApi= groupNotificationsByDate(listNotification);//List<NotificationsModel> listNotification= [];
            
             
            
          return Scaffold(
            appBar: defaultAppbar(title: "اشعارات", context: context),
            body: HandlingDataRequst(
              textNodata: "لا يوجد اشعارات",
              statusRequest:homeLayoutCubit.statusRequestNoti ,
              widget: Container(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ...List.generate(groupedApi.length, (indexKey) {
                      final key = groupedApi.keys.toList()[indexKey]; // المفتاح حسب الفهرس
                      final label=formatDateLabel(key); 
                      final items = groupedApi[key]!;
              
                      return Column(
                        
                        children: [
                          
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10,horizontal:10 ),
                            alignment: AlignmentDirectional.topStart,
                            child: Text("${label}",textAlign: TextAlign.start,style: TextStyle(
                              fontSize: 20,
                              color: AppColor.black,
                              fontWeight: FontWeight.bold
                              ),)),
                          
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return buildNotificationItem(model:items[index] );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 1),
                              itemCount:items.length
                              )
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
