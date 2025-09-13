import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/categories_model.dart';
import 'package:masar/model/top_courses_model.dart';
import 'package:masar/module/courses/cubit/courses_state.dart';
import 'package:masar/module/home/cubit/home_cubit.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/courses_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class CoursesCubit extends Cubit<CoursesState> {

final int initialValue;

  CoursesCubit({required this.initialValue}) : super(CoursesInitial()) {
    scrollController = ScrollController();
    currentIndexTap=initialValue;
    initTabs(categoriesGeneral);
   WidgetsBinding.instance.addPostFrameCallback((_) {
final contextTab = tabKeys[currentIndexTap].currentContext;
  if (contextTab != null) {
  Scrollable.ensureVisible(
      contextTab,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.5, // يجعله في وسط الشاشة
    );
  }
});
getData(categoriesGeneral[currentIndexTap].id!);
 // changeCurrentIndexTap(currentIndexTap);
  }

//CoursesCubit() : super(CoursesInitial());
static CoursesCubit get(BuildContext context)=> BlocProvider.of(context);
late ScrollController scrollController ;
List<GlobalKey> tabKeys = [];
//late  List<String> tabs;
 //   late List<Widget> pagestabs;
 late int currentIndexTap;
 
 
void initTabs(List<CategoriesModel> tabs) {
  tabKeys = List.generate(tabs.length, (_) => GlobalKey());
}

void changeCurrentIndexTap(int index) {
  currentIndexTap = index;
//
 
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
  emit(CoursesChangeIndexTapState());
}

  StatusRequest statusRequest = StatusRequest.none;
  CoursesData coursesData = CoursesData(Api());
  
  
  List<TopCoursesModel> courses = [];
  
  getData(int categoriesID) async {
  if (isClosed) return;
   statusRequest = StatusRequest.loading;
   if (!isClosed) emit(CoursesSuccessState());
    String token=CachHelper.getString(key: "token")!;
    
    var response = await coursesData.getData(token,categoriesID);
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        
          courses = [];
        ///////////////////
        List coursesResponse = response['data']['items'];
        courses.addAll(coursesResponse.map((e) => TopCoursesModel.fromJson(e)));
       //////////////
      if (courses.isEmpty) {
        statusRequest = StatusRequest.failure;
      }
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
  if (!isClosed)  emit(CoursesFinishState());
  }
  
  init(){
//  print("object");
//  tabs=['عني','الدورات','مراجعات'];
//  pagestabs=[AboutTeacher(),CoursesTeacher(),TeacherReview()];

}

}




