import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/top_courses_model.dart';
import 'package:masar/module/all_courses.dart/cubit/all_courses_state.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/all_courses_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class AllCoursesCubit extends Cubit<AllCoursesState> {
  AllCoursesCubit() : super(AllCoursesInitial());
  static AllCoursesCubit get(BuildContext context) => BlocProvider.of(context);
  StatusRequest statusRequest = StatusRequest.none;
  AllCoursesData allCoursesData = AllCoursesData(Api());

  List courses = [];

  getAllCourses() async {
    if (isClosed) return;
    statusRequest = StatusRequest.loading;
    if (!isClosed) emit(AllCoursesSuccessGetDataState());
    String token = CachHelper.getString(key: "token")!;
    var response = await allCoursesData.getData(token);
    statusRequest = handlingResponse(response);
    
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        courses = [];
        ///////////////////
        List coursesResponse = response['data']['items'];
        courses.addAll(coursesResponse.map((e) => TopCoursesModel.fromJson(e)));
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
    if (!isClosed) emit(AllCoursesFinshGetDataState());
  }

  init() {
    getAllCourses();
  }
}
