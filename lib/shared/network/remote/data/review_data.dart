import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class ReviewData {
  Api api;
ReviewData(this.api);
  getCourcesFeedback(String token,String courseID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.getCourcesFeedback}${courseID}/feedbacks",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
  

  createFeedback(String token,String course_id,String body,String rating)async{

   var response=await api.postDataWithToken(
    LinkApi.createFeedback,{
     "course_id":course_id,
     "body":body,
     "rating":rating,
    },
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }


}