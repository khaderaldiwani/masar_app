import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class CourseDetailsData{
  Api api;
CourseDetailsData(this.api);

getCourseDetails(String token,String courseID)async{
   var response=await api.getDataWithToken(
    "${LinkApi.courseDetails}${courseID}",
    token
    ); 
   return response.fold((l)=>l, (r)=>r);
  }


  getAnnouncements(String token,String courseID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.announcements}${courseID}/announcements",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
  getassessments(String token,String courseID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.assessments}${courseID}/assessments",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
  getAttendances(String token,String courseID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.attendances}${courseID}/attendances",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
  getReceiptsCourses(String token,String courseID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.receiptsCourses}${courseID}/receipts",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
}