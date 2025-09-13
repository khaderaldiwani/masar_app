import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class FavoriteData {
  Api api;
FavoriteData(this.api);
  createFavorite(String token,String CourseID)async{
   var response=await api.postDataWithToken(LinkApi.createFavorite,{
    "favoritable_id":CourseID,
    "favoritable_type":"course",

   },token); 

   return response.fold((l)=>l, (r)=>r);
  }

  
  deleteFavorite(String token,String courseID,String studentID)async{
   var response=await api.deleteDataWithToken("${LinkApi.deleteFavorite}$courseID/$studentID",token); 

   return response.fold((l)=>l, (r)=>r);
  }

  getallFavorite(String token)async{
   var response=await api.getDataWithToken(LinkApi.getallFavorite,token); 

   return response.fold((l)=>l, (r)=>r);
  }

}