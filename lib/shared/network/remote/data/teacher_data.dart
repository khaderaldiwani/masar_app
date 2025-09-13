import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class TeacherData {
  Api api;
TeacherData(this.api);
  getData(String token,String TeacherID)async{
   var response=await api.getDataWithToken("${LinkApi.teacherProfile}$TeacherID/profile",token); 
   return response.fold((l)=>l, (r)=>r);
  }

  teacherCourses(String token,String teacherID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.teacherCourses}${teacherID}/courses",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }


  getTeacherFeedback(String token,String teacherID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.teacherFeedback}${teacherID}/feedbacks",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
  
}