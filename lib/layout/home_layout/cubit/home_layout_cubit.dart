import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/layout/home_layout/cubit/home_layout_states.dart';
import 'package:masar/model/notifications_model.dart';
import 'package:masar/module/home/home.dart';
import 'package:masar/module/my_courses/my_courses.dart';
import 'package:masar/module/receipts/receipts.dart';
import 'package:masar/module/setting/setting.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/notifications_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../../shared/components/components/home_layout_component.dart';

List<NotificationsModel> listNotification= [];
class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutStateInit()){
    init();
  }
  static HomeLayoutCubit get(BuildContext context) => BlocProvider.of(context);
  int currentIndexAnnoun = 0;
  PageController? pageController = PageController(initialPage: 0);
  late Timer timer;
  int currentIndexBottomNavBar = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.menu_book_outlined,
        ),
        label: "كورساتي"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.my_library_books_outlined), label: "ايصالات"),
    const BottomNavigationBarItem(icon: Icon(Icons.menu), label: "المزيد"),
  ];
  List<Widget> pages=[Home(),MyCourses(),Receipts(),Setting()];
   List<AppBar> listappBar(BuildContext context){
      bool back=CachHelper.getBool(key: "noti")!; 
    List<AppBar> appBar=[
    customAppbarHome(
      onPressedFavo:(){
      Navigator.pushNamed(context, AppRoute.favorite);  
      } ,
      is_read:listNotification.isEmpty? true :listNotification[0].isRead!&&back ,
      onImage: (){
      Navigator.pushNamed(context, AppRoute.profile);
 
      },
      onPressedNoti: (){
     // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(), ));
      
      Navigator.pushNamed(context, AppRoute.notification).whenComplete(() {
  // لما ترجع من صفحة Notification
  getDataNoti(); 
  CachHelper.putBool(key: "noti", value: true);//"noti"
});

    }),
    AppbarHomeLayout(title: 'كورساتي', context:context),
    AppbarHomeLayout(
      title: 'الايصالات',  context:context
     
      ),
    
    AppbarHomeLayout(title: 'الاعدادات', context:context )
    ];
    emit(HomeLayoutRefreshAppBarState());
    return appBar;
   
   }
   
NotificationsData notificationsData = NotificationsData(Api());
  
  
  List temp= [
        // {
        //     "id": "54f63b57-9837-414f-ba71-62f232c67fbd",
        //     "data": {
        //         "message": "hello students"
        //     },
        //     "time": "15:31:46",
        //     "date": "2025-08-22",
        //     "is_read": true
        // },
        // {
        //     "id": "06245552-995e-48bf-89ca-b152230331b0",
        //     "data": {
        //         "message": "مرحبا خضر الديواني"
        //     },
        //     "time": "15:28:28",
        //     "date": "2025-08-22",
        //     "is_read": false
        // },
        // {
        //     "id": "11604630-5338-4d86-b72b-a1920e73028d",
        //     "data": {
        //         "message": " سيوظزسيوبزظسوزظبوسيزظبوسيزظوبزظسوبزظسوزبظسوزظبوسظزبوسظزوبسظزوبزظوسظزوسظزوبزسظوبزظسوظزبوسزظبوسظوبزس وبظزسوبظزومرحبا خضر الديواني"
        //     },
        //     "time": "15:25:50",
        //     "date": "2025-08-21",
        //     "is_read": false
        // },
        // {
        //     "id": "a3ca6d0c-775c-475e-a9fa-524d0b6b8fbc",
        //     "data": {
        //         "message": "يمرحبا خضر الديواني"
        //     },
        //     "time": "15:23:16",
        //     "date": "2025-08-20",
        //     "is_read": false
        // }
    ];
StatusRequest statusRequestNoti = StatusRequest.none;
 
  getDataNoti() async {
      
   statusRequestNoti = StatusRequest.loading;
   emit(HomeLayoutSuccessGetDataState());
    String token=CachHelper.getString(key: "token")!;
    
    var response = await notificationsData.getData(token);
    statusRequestNoti = handlingResponse(response);
    
    if (statusRequestNoti == StatusRequest.success) {
      if (response['success'] == true) {
        listNotification = [];
        
        List notiResponse= response['data'];
        listNotification.addAll(notiResponse.map((e) => NotificationsModel.fromJson(e)));
        ///////////////////
     if (listNotification.isEmpty) {
     statusRequestNoti = StatusRequest.failure;        
     }   
       
      } 
      // else 
      // {
      //   statusRequestNoti = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequestNoti = StatusRequest.failure;
    // }
    emit(HomeLayoutFnishGetDataState());
  }
    
      
   void changeBottomNavBar(int index) {
    currentIndexBottomNavBar = index;
    emit(HomeLayoutChangeBottomNavBarState());
  }

  void init() {
   // getDataNoti();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("==========Frontgrount");
      getDataNoti();
      print("==========Foreground");

  final title = message.notification?.title ?? "إشعار جديد";
  final body = message.notification?.body ?? "يوجد لديك اشعار جديد يمكن تفقد اشعاراتك";
  showSimpleNotification(
    Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.white)),
    subtitle: Text(body, style: TextStyle(color: AppColor.white)),
    background: AppColor.primaryColor,
    autoDismiss: true,
    duration: Duration(seconds: 4),
    slideDismissDirection: DismissDirection.up,
  );
  //   ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
  //   SnackBar(
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
  //         Text(body),
  //       ],
  //     ),
  //     duration: Duration(seconds: 3), // يظهر 3 ثواني ويختفي
  //     behavior: SnackBarBehavior.floating, // يطفو (أنيق أكثر)
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     margin: EdgeInsets.all(12), // مسافة عن الأطراف
  //   ),
  // );
  
    });
  }
}






