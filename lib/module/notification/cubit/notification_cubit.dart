import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:masar/layout/home_layout/cubit/home_layout_cubit.dart';
import 'package:masar/module/notification/cubit/notification_state.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/notifications_read_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
 static  NotificationCubit get(BuildContext context)=>BlocProvider.of(context) ;
 
StatusRequest statusRequest = StatusRequest.none;
  NotificationsReadData notificationsReadData = NotificationsReadData(Api());

  
Future<void> postReadNoti() async {
      if(isClosed)return;
 //   emit(NotificationSuccessGetDataState());
    String token=CachHelper.getString(key: "token")!;
    
    var response = await notificationsReadData.postData(token) ;
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        
        print('success');
        
       
      } 
      else {
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
 if(!isClosed)   emit(NotificationFinshGetDataState());
  }
Future<void> init()async{
await postReadNoti();

}
}

