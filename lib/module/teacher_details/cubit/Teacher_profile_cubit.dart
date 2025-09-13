import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/course_details_model.dart';
import 'package:masar/model/feedback_model.dart';
import 'package:masar/model/teacher_profile_model.dart';
import 'package:masar/model/top_courses_model.dart';
import 'package:masar/module/about_teacher/about_teacher.dart';
import 'package:masar/module/courses_teacher/courses_teacher.dart';
import 'package:masar/module/teacher_details/cubit/Teacher_profile_state.dart';
import 'package:masar/module/teacher_review/teacher_review.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/teacher_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class TeacherProfileCubit extends Cubit<TeacherProfileState> {
final String teacherID;
TeacherProfileCubit ({required this.teacherID}) : super(TeacherProfileInitial()){
init();
getData();
}
  static TeacherProfileCubit get(BuildContext context)=> BlocProvider.of(context);
final ScrollController scrollController = ScrollController();
List<GlobalKey> tabKeys = [];
late  List<String> tabs;
    late List<Widget> pagestabs;
  int currentIndexTap=0;
 bool expanded = false;
    bool isView=false;
    void showText(){
 expanded = !expanded;
 emit(TeacherProfileShowMore());
}
void initTabs(List<String> tabs) {
  tabKeys = List.generate(tabs.length, (_) => GlobalKey());
}
void changeCurrentIndexTap(int index) {
  currentIndexTap = index;

  // نحصل على Context الخاص بالتاب المطلوب
  final contextTab = tabKeys[index].currentContext;
  if (contextTab != null) {
    Scrollable.ensureVisible(
      contextTab,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.5, // يجعله في وسط الشاشة
    );
  }

  emit(TreacherDetailsChangeIndexTap());
}

StatusRequest statusRequest = StatusRequest.none;
StatusRequest statusRequestProfile = StatusRequest.none;
TeacherData teacherProfileData = TeacherData(Api());

TeacherProfileModel teacherProfile=TeacherProfileModel()  ;
  
  getData() async {
    if (isClosed) return;
    statusRequestProfile = StatusRequest.loading;
    if (!isClosed) emit(TeacherProfileSuccessRequstState());
    String token = CachHelper.getString(key: "token")!;
    var response = await teacherProfileData.getData(token,teacherID);
    statusRequestProfile = handlingResponse(response);
    if (statusRequestProfile == StatusRequest.success) {
      if (response['success'] == true) {
        ///////////////////
        Map profileResponse = response['data'];
        teacherProfile= TeacherProfileModel.fromJson(Map<String, dynamic>.from(profileResponse));
        
        
   //////////////
        // if (categories.isEmpty) {
        //   statusRequest = StatusRequest.failure;
        // }
      }
      //  else {
      //   statusRequest = StatusRequest.failure;
      // }
    }
    //  else {
    //   statusRequest = StatusRequest.failure;
    // }
    if (!isClosed) emit(TeacherProfileSuccessRequstState());
  }
   
   
  List<TopCoursesModel> courses = [];
  getCourses() async {
    if (isClosed) return;
    statusRequest = StatusRequest.loading;
    if (!isClosed) emit(TeacherProfileSuccessRequstState());
    String token = CachHelper.getString(key: "token")!;
    var response = await teacherProfileData.teacherCourses(token,teacherID);
    statusRequest = handlingResponse(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        ///////////////////
        courses = [];
           List coursesResponse = response['data'];
        courses.addAll(coursesResponse.map((e) => TopCoursesModel.fromJson(e)));
     
   //////////////
        if (courses.isEmpty) {
          statusRequest = StatusRequest.failure;
        }
      }
      //  else {
      //   statusRequest = StatusRequest.failure;
      // }
    }
    //  else {
    //   statusRequest = StatusRequest.failure;
    // }
    if (!isClosed) emit(TeacherProfileSuccessRequstState());
  }
 
 int count= 0;
  int average= 0;
  List<FeedBackModel> listFeedBack = [];
  getFeedBack() async {
    if (isClosed) return;
    statusRequest = StatusRequest.loading;
    if (!isClosed) emit(TeacherProfileSuccessRequstState());
    String token = CachHelper.getString(key: "token")!;
    var response = await teacherProfileData.getTeacherFeedback(token,teacherID);
    statusRequest = handlingResponse(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        ///////////////////
        
        listFeedBack = [];
         count=response['data']['count'];
        average=response['data']['average'];
        List FeedBackResponse = response['data']['feedbacks'];
        listFeedBack.addAll(FeedBackResponse.map((e) => FeedBackModel.fromJson(e)));
     
   //////////////
        if (listFeedBack.isEmpty) {
          statusRequest = StatusRequest.failure;
        }
      }
      //  else {
      //   statusRequest = StatusRequest.failure;
      // }
    }
    //  else {
    //   statusRequest = StatusRequest.failure;
    // }
    if (!isClosed) emit(TeacherProfileSuccessRequstState());
  }
   
init(){
  tabs=['عني','الدورات','مراجعات'];
  pagestabs=[AboutTeacher(),CoursesTeacher(),TeacherReview()];
 initTabs(tabs);

}

}
