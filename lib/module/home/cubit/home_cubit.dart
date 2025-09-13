import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/ads-model.dart';
import 'package:masar/model/categories_model.dart';
import 'package:masar/model/top_courses_model.dart';
import 'package:masar/model/top_teachers_model.dart';
import 'package:masar/module/home/cubit/home_state.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/home_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';
List<CategoriesModel> categoriesGeneral = [];
class HomeCubit extends Cubit<HomeState> {
  HomeCubit():super(HomeStateInit());
  static HomeCubit get(BuildContext context)=>BlocProvider.of(context);
  int currentIndexAnnoun=0;
  PageController? pageController;
  late  Timer timer;
      next()async{
    currentIndexAnnoun++;
    if(currentIndexAnnoun == ads.length ){//3ads listOnboardingModel.length
    await  Future.microtask(() {
        currentIndexAnnoun=0;
        pageController!.jumpToPage(currentIndexAnnoun);
      });
    }else{
     // pageController!.jumpToPage(currentIndexAnnoun);
       pageController!.animateToPage(currentIndexAnnoun, duration: Duration(milliseconds:250 ), curve:Curves.easeInOut );
  
    } 

  emit(HomeChangeAnnounState());
  }

  changeAnnoun(int val){
    if(val<ads.length)
    {
      currentIndexAnnoun =val;
    
    }
    if(val >= ads.length ){//4
      Future.microtask(() {
       
        currentIndexAnnoun=0;
        pageController!.jumpToPage(currentIndexAnnoun);
       
      });
    }
    
    emit(HomeChangeAnnounState());
  }
  goToTeacherProfile(BuildContext context,String teacherID){
    Navigator.pushNamed(context, AppRoute.TeacherProfile,arguments: teacherID);
    
  }
StatusRequest statusRequest = StatusRequest.none;

StatusRequest statusRequestads = StatusRequest.none;
StatusRequest statusRequesttopTeachers = StatusRequest.none;
StatusRequest statusRequesttopCourses = StatusRequest.none;
  HomeData homeData = HomeData(Api());
  
  List<AdsModel> ads = [];
  List<TopTeachersModel> topTeachers = [];
  List<CategoriesModel> categories = [];
  List<TopCoursesModel> topCourses = [];

  getData() async {
      

    statusRequest = StatusRequest.loading;
    emit(HomeSuccessGetDataState());
    String token=CachHelper.getString(key: "token")!;
    
    var response = await homeData.getData(token);
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        ads = [];
   topTeachers=[];
   categories = [];
   topCourses = [];
   categoriesGeneral = [];
        /////////////
        List adsResponse = response['data']['ads'];
        ads.addAll(adsResponse.map((e) => AdsModel.fromJson(e)));
     ads.isEmpty?statusRequestads==StatusRequest.failure:
     statusRequestads==StatusRequest.success;
        ///////////////////
        List topTeachersResponse = response['data']['top_teachers'];
        topTeachers.addAll(topTeachersResponse.map((e) => TopTeachersModel.fromJson(e)));
       topTeachers.isEmpty?statusRequesttopTeachers==StatusRequest.failure:
     statusRequesttopTeachers==StatusRequest.success;
        // //////////////
            
        ///////////////////
        List categoriesResponse = response['data']['categories'];
        categories.addAll(categoriesResponse.map((e) => CategoriesModel.fromJson(e)));
       
        categoriesGeneral.addAll(categoriesResponse.map((e) => CategoriesModel.fromJson(e)));
       
       //////////////
            
        ///////////////////
        List topCoursesResponse = response['data']['top_courses'];
        topCourses.addAll(topCoursesResponse.map((e) => TopCoursesModel.fromJson(e)));
      topCourses.isEmpty?statusRequesttopCourses==StatusRequest.failure:
     statusRequesttopCourses==StatusRequest.success;
        // //////////////
            
     } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
    emit(HomeFinshGetDataState());
  }

Future<void> refresh() async {
  
  getData();
    // ممكن تحدث البيانات هنا
    emit(HomeRefreshScreenState());
  }
  void init(){
    currentIndexAnnoun=0;
    pageController=PageController(initialPage: 0);

//getData();

// timer = Timer.periodic(Duration(seconds: 5), (timer)  {
//    next(); 
// },);

   }
}