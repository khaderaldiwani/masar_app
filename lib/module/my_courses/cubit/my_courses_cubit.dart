
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/courses_completed_model.dart';
import 'package:masar/model/courses_ongoing_model.dart';
import 'package:masar/model/courses_upcoming_model.dart';
import 'package:masar/module/my_courses/cubit/my_courses_state.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/my_courses_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class MyCoursesCubit extends Cubit<MyCoursesState> {
  MyCoursesCubit() : super(MyCoursesInitial());
 static  MyCoursesCubit get(BuildContext context)=>BlocProvider.of(context) ;
 bool isOngoing=true;
 changeOngoing(bool Ongoing){
isOngoing=Ongoing;
emit(MyCoursesChangeOngoing());
 }

StatusRequest statusRequestUpcoming = StatusRequest.none;
StatusRequest statusRequestOngoing = StatusRequest.none;
StatusRequest statusRequestCompleted = StatusRequest.none;

MyCoursesData myCoursesData = MyCoursesData(Api());
///////////////////////////
List<CoursesUpcomingModel> listCoursesUpcoming=[];

List tempUpcoming=  [
        {
            "id": 1,
            "name": "اللغة الإنكليزية",
            "start_date": "2025-11-11",
            "teacher": {
                "id": 1,
                "first_name": "مؤيد",
                "last_name": "العبدالله",
                "image": "/storage/teacher_image.jpg"
            }
        }
    ];
 
 getCoursesUpcoming() async {
      if (isClosed) return;
      listCoursesUpcoming = [];
   statusRequestUpcoming = StatusRequest.loading;
  if (!isClosed)  emit(MyCoursesCoursesSuccessRequestState());
    String token=CachHelper.getString(key: "token")!;
    
    var response = await myCoursesData.getMyCoursesUpcoming(token);
    statusRequestUpcoming = handlingResponse(response);
    print(response);
    if (statusRequestUpcoming == StatusRequest.success) {
      if (response['success'] == true) {
        List UpcomingResponse = response['data'];//tempUpcoming;
        listCoursesUpcoming.addAll(UpcomingResponse.map((e) =>CoursesUpcomingModel.fromJson(e)));
       //////////////
       if (listCoursesUpcoming.isEmpty) {
                 statusRequestUpcoming = StatusRequest.failure;

       }
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
 if (!isClosed)   emit(MyCoursesFinishRequestState());
  }

///////////////////////////
List<CoursesOngoingModel> listCoursesOngoing=[];

List tempongoing= [
        {
            "id": 1,
            "name": "اللغة الإنكليزية",
            "progress_percentage": 13.64,
            "teacher": {
                "id": 1,
                "first_name": "مؤيد",
                "last_name": "العبدالله",
                "image": "${CachHelper.getString(key: "image")}"
            }
        }
    ];
 
 getCoursesOngoing() async {
       if (isClosed) return; // منع الخطأ
      listCoursesOngoing = [];
   statusRequestOngoing = StatusRequest.loading;
   if (!isClosed) emit(MyCoursesCoursesSuccessRequestState());
    String token=CachHelper.getString(key: "token")!;
    
    var response = await myCoursesData.getMyCoursesOngoing(token);
    statusRequestOngoing = handlingResponse(response);
    print(response);
    if (statusRequestOngoing == StatusRequest.success) {
      if (response['success'] == true) {
        List OngoingResponse = response['data'];//tempongoing
        listCoursesOngoing.addAll(OngoingResponse.map((e) =>CoursesOngoingModel.fromJson(e)));
       //////////////
     if (listCoursesOngoing.isEmpty) {
                 statusRequestOngoing = StatusRequest.failure;

       }
      } 
      // else {
      //   statusRequestCompleted = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
    if (!isClosed)emit(MyCoursesFinishRequestState());
  }

///////////////////////


List<CoursesCompletedModel> listCoursesCompleted=[];

List tempCompleted= [
        // {
        //     "id": 1,
        //     "name": "اللغة الإنكليزية",
        //     "end_date": "2025-09-01",
        //     "teacher": {
        //         "id": 1,
        //         "first_name": "مؤيد",
        //         "last_name": "العبدالله",
        //         "image": "${CachHelper.getString(key: "image")}"
        //     }
        // }
    ];
 
 getCoursesCompleted() async {
       if (isClosed) return; // منع الخطأ
      listCoursesCompleted = [];
   statusRequestCompleted = StatusRequest.loading;
   if (!isClosed) emit(MyCoursesCoursesSuccessRequestState());
    String token=CachHelper.getString(key: "token")!;
    
    var response = await myCoursesData.getMyCoursesCompleted(token);
    listCoursesCompleted = [];
    statusRequestCompleted = handlingResponse(response);
    print(response);
    if (statusRequestCompleted == StatusRequest.success) {
      if (response['success'] == true) {
        List completedRespone = response['data'];//tempCompleted;//
        listCoursesCompleted.addAll(completedRespone.map((e) =>CoursesCompletedModel.fromJson(e)));
       //////////////
       if (listCoursesCompleted.isEmpty) {
                 statusRequestCompleted = StatusRequest.failure;

       }
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
    if (!isClosed) emit(MyCoursesFinishRequestState());
  }


//////////////



}
