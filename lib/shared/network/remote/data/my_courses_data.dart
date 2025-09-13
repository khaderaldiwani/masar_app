import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class MyCoursesData {
  Api api;
MyCoursesData(this.api);
  getMyCoursesUpcoming(String token)async{
   var response=await api.getDataWithToken(LinkApi.myCoursesUpcoming,token); 
   return response.fold((l)=>l, (r)=>r);
  }
  getMyCoursesOngoing(String token)async{
   var response=await api.getDataWithToken(LinkApi.myCoursesOngoing,token); 
   return response.fold((l)=>l, (r)=>r);
  }
  getMyCoursesCompleted(String token)async{
   var response=await api.getDataWithToken(LinkApi.myCoursesCompleted,token); 
   return response.fold((l)=>l, (r)=>r);
  }
}