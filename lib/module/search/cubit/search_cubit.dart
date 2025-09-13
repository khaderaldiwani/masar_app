import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/top_courses_model.dart';
import 'package:masar/module/search/cubit/search_state.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/search_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static  SearchCubit get(BuildContext context)=>BlocProvider.of(context) ;
 
 String level="1";
 String time="+4";
 //String certificate="all";
 String orderBy="newest";
bool isSearch=false;
String? search;    
   changeLevel(String val){
    print(val);
    level=val;
   emit(SearchChangeLevelState()); 
   }
   changeTime(String val){
    time=val;
    print(time);
   emit(SearchChangeTimeState()); 
   }
   
   ChangeModeSearch(String? val){
    search=val;
    if(val!.isEmpty)
    {
       isSearch=false;
   
    }
    else{
      isSearch=true;
    }
    emit(SearchChangeModeSearchState());
   }
   changeOrderBy(String val){
    orderBy=val;
   emit(SearchChangeOrderByState()); 
   }
StatusRequest statusRequest = StatusRequest.none;
  SearchData searchData = SearchData(Api());
  
  
  List courses = [];


 getData(String? val) async {
      
if(isClosed) return;
    statusRequest = StatusRequest.loading;
if(!isClosed)  emit(SearchSuccessGetDataState());
    String token=CachHelper.getString(key: "token")!;
    
    var response = await searchData.getData(token,val,level,time,orderBy);
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
    //  else {
    //   statusRequest = StatusRequest.failure;
    // }
 if(!isClosed)   emit(SearchFinshGetDataState());
  }

}
