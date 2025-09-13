import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/top_courses_model.dart';
import 'package:masar/module/favorite.dart/cubit/favorite_state.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/favorite_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  static FavoriteCubit get(BuildContext context) => BlocProvider.of(context);
  StatusRequest statusRequest = StatusRequest.none;
  FavoriteData favoriteData = FavoriteData(Api());

  List<TopCoursesModel> listFourses = [];

  getAllCoursesFavorite() async {
    if (isClosed) return;
    statusRequest = StatusRequest.loading;
    if (!isClosed) emit(FavoriteSuccessGetDataState());
    String token = CachHelper.getString(key: "token")!;
    var response = await favoriteData.getallFavorite(token);
    statusRequest = handlingResponse(response);
    
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        listFourses = [];
        ///////////////////
        List coursesResponse = response['data'];
        listFourses.addAll(coursesResponse.map((e) => TopCoursesModel.fromJson(e)));
        
        ////////////
        if (coursesResponse.isEmpty) {
          statusRequest = StatusRequest.failure;
        }
      }
      // else {
      // }
    } 
    // else {
    //   //  statusRequest = StatusRequest.failure;
    // }
    if (!isClosed) emit(FavoriteFinishGetDataState());
  }


deleteFavorite(String courceID) async{
  //   statusRequest = StatusRequest.loading;
 //     emit(CourseDetailsSuccessCreateQuestionState());
 if (isClosed) return;
      String token = CachHelper.getString(key: "token")!;
      String studentId = CachHelper.getString(key:"id")!;
     
     // var response = 
      await favoriteData.deleteFavorite(token, courceID,studentId);
          getAllCoursesFavorite();
     // statusRequest = handlingResponse(response);
     // print(response);
      // if (statusRequest == StatusRequest.success) {
      //   if (response['success'] == true) {
      //     ///////////////////
      //     await question();
      //     commentCtrl.clear();
      //     scrollControllerListview.animateTo(
      //         scrollControllerListview.position.maxScrollExtent + 80.0,
      //         duration: const Duration(seconds: 1),
      //         curve: Curves.easeIn);
      //     //  Map questionResponse = response['data'];
      //     //  QuestionModel  receiptDetails= QuestionModel.fromJson(Map<String, dynamic>.from(questionResponse));
      //     //   listQuestions.add(receiptDetails);
      //     //   initExpandedList(listQuestions.length);
      //     //////////////
      //   } else {
      //     statusRequest = StatusRequest.failure;
      //   }
      // } else {
      //   statusRequest = StatusRequest.failure;
      // }
     if (!isClosed)  emit(FavoriteFinishGetDataState());
    
  }
  

}
