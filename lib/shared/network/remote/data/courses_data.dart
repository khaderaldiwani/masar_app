import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class CoursesData {
  Api api;
CoursesData(this.api);
  getData(String token,int categoriesID)async{
   var response=await api.getDataWithToken("${LinkApi.courses}${categoriesID}",token); 

   return response.fold((l)=>l, (r)=>r);
  }
}