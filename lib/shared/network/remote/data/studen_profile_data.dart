import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class StudenProfileData {
  Api api;
StudenProfileData(this.api);
  getStudentProfile(String token,)async{
   var response=await api.getDataWithToken(LinkApi.studentProfile,token); 
   return response.fold((l)=>l, (r)=>r);
  }

  getCoursesStudent(String token,)async{
   var response=await api.getDataWithToken(LinkApi.coursesStudentProfile,token); 
   return response.fold((l)=>l, (r)=>r);
  }

}